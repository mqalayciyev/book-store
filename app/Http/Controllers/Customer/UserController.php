<?php

namespace App\Http\Controllers\Customer;

use App\Http\Controllers\Controller;
use App\Mail\ResetPassword;
use App\Mail\UserRegistration;
use App\Models\Cart as CartModel;
use App\Models\CartProduct;
use App\Models\PasswordReset;
use App\Models\UserDetail;
use App\Models\Product;
use App\User;
use Carbon\Carbon;
use DB;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function sign_up_form()
    {
        return view('customer.pages.user.sign_up');
    }

    public function sign_up()
    {
        $messages = [
            'first_name.required' => 'Ad qeyd edilməyib.',
            'first_name.min' => 'Ad minimum 3 simvol olmalıdır.',
            'last_name.required' => 'Soyad qeyd edilməyib.',
            'last_name.min' => 'Soyad minimum 3 simvol olmalıdır.',
            'email.required'  => 'Email boş ola bilməz.',
            'email.email'  => 'Düzgün email forması daxil edin.',
            'email.unique'  => 'Bu email artıq qeydiyyatdan keçib.',
            'email.min' => 'Email minimum 5 simvol olmalıdır.',
            'mobile.required' => 'Nömrə qeyd edilməyib',
            'password.required'  => 'Şifrə boş ola bilməz.',
            'password.min'  => 'Şifrə minimum 8 simvol omalıdır.',
            'password.confirmed'  => 'Şifrələr uyğun deyil.',
        ];
        $this->validate(request(), [
            'first_name' => 'required|min:3',
            'last_name' => 'required|min:3',
            'email' => 'required|email|unique:user|min:5',
            'mobile' => 'required',
            'password' => 'required|confirmed|min:8'
        ], $messages);

        $user = User::create([
            'first_name' => request('first_name'),
            'last_name' => request('last_name'),
            'email' => request('email'),
            'mobile' => request('mobile'),
            'password' => Hash::make(request('password')),
            // 'activation_key' => Str::random(60),
            'is_active' => 1
        ]);

        $credentials = [
            'email' => request('email'),
            'password' => request('password'),
            'is_active' => 1
        ];
        if (auth()->attempt($credentials)) {
            request()->session()->regenerate();
            $active_cart_id = CartModel::active_cart_id();
            if (is_null($active_cart_id)) {
                $active_cart = CartModel::create(['user_id' => auth()->id()]);
                $active_cart_id = $active_cart->id;
            }
            session()->put('active_cart_id', $active_cart_id);

            if (Cart::count() > 0) {
                foreach (Cart::content() as $cartItem) {
                    $size = $cartItem->options->size; 
                    $color = $cartItem->options->color; 
                    CartProduct::updateOrCreate(
                        ['cart_id' => $active_cart_id, 'product_id' => $cartItem->id, 'size' => $size, 'color' => $color],
                        ['piece' => $cartItem->qty, 'amount' => $cartItem->price, 'status' => 'Pending', 'size' => $size, 'color' => $color]
                    );
                }
            }

            Cart::destroy();
            $cartProducts = CartProduct::where('cart_id', $active_cart_id)->get();
            foreach ($cartProducts as $cartProduct) {
                $product = Product::find($cartProduct->product_id);
                if($product){
                    Cart::add($cartProduct->product_id, 
                                $product->product_name, 
                                $cartProduct->piece, 
                                $cartProduct->amount, 
                                ['slug' => $product->slug, 
                                'discount' => $product->discount, 
                                'image' => $product->image->main_name,
                                'size' => $cartProduct->size,
                                'color' => $cartProduct->color]);
                    
                }
                else{
                    CartProduct::where('cart_id', $active_cart_id)->where('product_id', $cartProduct->product_id)->delete();
                }
            }
            // Mail::to(request('email'))->send(new UserRegistration($user));
            return redirect()->intended('/account');
        }
        else {
            $errors = ['email' => __('content.Incorrect entry')];
            return back()->withErrors($errors);
        }
    }

    public function sign_in_form()
    {
        return view('customer.pages.user.sign_in');
    }

    public function sign_in()
    {
        $messages = [
            'email.required'  => 'Email boş ola bilməz.',
            'email.email'  => 'Düzgün email forması daxil edin.',
            'password.required'  => 'Şifrə boş ola bilməz.',
        ];
        $this->validate(request(), [
            'email' => 'required|email',
            'password' => 'required'
        ], $messages);

        $credentials = [
            'email' => request('email'),
            'password' => request('password'),
            'is_active' => 1
        ];
        if (auth()->attempt($credentials, request()->has('remember_me'))) {
            request()->session()->regenerate();
            $active_cart_id = CartModel::active_cart_id();
            if (is_null($active_cart_id)) {
                $active_cart = CartModel::create(['user_id' => auth()->id()]);
                $active_cart_id = $active_cart->id;
            }
            session()->put('active_cart_id', $active_cart_id);

            if (Cart::count() > 0) {
                foreach (Cart::content() as $cartItem) {

                    CartProduct::updateOrCreate(
                        ['cart_id' => $active_cart_id, 'product_id' => $cartItem->id],
                        ['piece' => $cartItem->qty, 'amount' => $cartItem->price, 'status' => 'Pending']
                    );
                }
            }

            Cart::destroy();
            $cartProducts = CartProduct::where('cart_id', $active_cart_id)->get();
            foreach ($cartProducts as $cartProduct) {
                Cart::add($cartProduct->product->id, $cartProduct->product->product_name, $cartProduct->piece, $cartProduct->amount, ['slug' => $cartProduct->product->slug, 'discount' => $cartProduct->product->discount, 'image' => $cartProduct->product->image->main_name]);
            }

            return redirect()->intended('/');
        } else {
            $errors = ['email' => __('content.Incorrect entry')];
            return back()->withErrors($errors);
        }
    }

    public function activate($activation_key)
    {
        $user = User::where('activation_key', $activation_key)->first();
        if (!is_null($user)) {
            $user->activation_key = null;
            $user->is_active = 1;
            $user->save();
            return redirect()->to('/')
                ->with('message', 'Your user registration has been activated')
                ->with('message_type', 'success');
        } else {
            return redirect()->to('/')
                ->with('message', 'Your user is already enabled')
                ->with('message_type', 'warning');
        }
    }
    public function my_account(){
        $user_detail = UserDetail::where('user_id', auth()->id())->first();
        return view('customer.pages.user.my_account', [
            'user_detail' => $user_detail,
        ]);
    }
    public function form_info(){
        $validator = Validator::make(request()->all(), [
            'first_name' => 'required',
            'last_name' => 'required',
            'email' => 'required',
            'mobile' => 'required',
        ], [
            'first_name.required' => 'Ad daxil edilmeyib.',
            'last_name.required' => 'Soyad daxil edilmeyib.',
            'email.required' => 'Email daxil edilmeyib.',
            'mobile.required' => 'Mobile nomre daxil edilmeyib.',
            
            ]);
        if ($validator->fails()) {
            return response()->json(['status' => 'error', 'message' => $validator->errors()]);
        }
        
        User::where('id', auth()->id())->update([
            'first_name' => request('first_name'),
            'last_name' => request('last_name'),
            'email' => request('email'),
            'mobile' => request('mobile'),
        ]);
        UserDetail::updateOrCreate(['user_id' =>  auth()->id()], [
            'country' => request('country'),
            'state' => request('state'),
            'city' => request('city'),
            'zip_code' => request('zip_code'),
            'address' => request('address'),
        ]);
        return response()->json(['status' => 'success']);
    }
    public function form_detail(){
        $validator = Validator::make(request()->all(), [
            'country' => 'required',
            'state' => 'required',
            'city' => 'required',
            'address' => 'required',
        ], [
            'country.required' => 'Ölkə daxil edilmeyib.',
            'state.required' => 'Paytaxt daxil edilmeyib.',
            'city.required' => 'Şəhər daxil edilmeyib.',
            'address.required' => 'Address daxil edilmeyib.',
            
            ]);
        if ($validator->fails()) {
            return response()->json(['status' => 'error', 'message' => $validator->errors()]);
        }
        UserDetail::updateOrCreate(['user_id' =>  auth()->id()], [
            'country' => request('country'),
            'state' => request('state'),
            'city' => request('city'),
            'zip_code' => request('zip_code'),
            'address' => request('address'),
        ]);
        return response()->json(['status' => 'success']);
    }
    public function form_password(){
        
        
        $user = Auth::user();

        
        $validator = Validator::make(request()->all(), [
            'password'              => 'required|min:6',
            'password_confirmation' => 'required|same:password',
            'old_password' => ['required', function ($attribute, $value, $fail) use ($user) {
                if (!Hash::check($value, $user->password)) {
                    return $fail("Kohne sifre duzgun daxil edilmeyib.");
                }
            }]
        ], [
            'old_password.required' => 'Kohne sifre qeyd edilmeyib.',
            'password.required' => 'Sifre qeyd edilmeyib.',
            'password_confirmation.required' => 'Sifre(tekrar) qeyd edilmeyib.',
            'password_confirmation.same' => 'Sifreler uygun deyil.',
            
            ]);
        
        if ($validator->fails()) {
            return response()->json(['status' => 'error', 'message' => $validator->errors()]);
        }
        
        User::find(auth()->id())->update([
            'password'=> Hash::make(Input::get('password')),
        ]);
        return response()->json(['status' => 'success']);
    }
    public function reset_password_form(){
        return view('customer.pages.user.reset_password');
    }
    public function reset_password(){
        $user = User::where('email', '=', request('email'))->first();
        $count =User::where('email', '=', request('email'))->count();
        //Check if the user exists
        if ($count < 1) {
            return redirect()->back()->withErrors(['email' => trans('İstifadəçi mövcud deyil')]);
        }

        //Create Password Reset Token
        $token = str_random(60);
        PasswordReset::insert([
            'email' =>request('email'),
            'token' => $token,
            'created_at' => Carbon::now()
        ]);
        $reset = ['link' => 'http://demo.ecommerce.inova.az/user/reset_password', 'token' => $token, 'email' => request('email')];
        Mail::to(request('email'))->send(new ResetPassword($reset));
        return redirect()->back()->with('message', trans('Sıfırlama linki elektron poçt ünvanınıza göndərildi.'));
    }
    public function resetPassword($email, $token)
    {
        $count = PasswordReset::where('email', $email)
            ->where('token', $token)
            ->where('deleted_at', NULL)
            ->count();
        if($count > 0){
            return view('customer.pages.user.change_password', [
                'email' => $email,
                'token' => $token
            ]);
        }
        else{
            return view('customer.pages.user.error_token');
        }
        

    }
    public function change_password(){
        $this->validate(request(), [
            'password'              => 'required|min:6',
            'password_confirmation' => 'required|same:password'
        ]);
        User::where('email', request('email'))->update([
            'password' => Hash::make(request('password')),
        ]);
        PasswordReset::where('email', request('email'))
            ->where('token', request('token'))
            ->delete();
        return redirect()->route('user.sign_in')->with('message', 'Şifrəniz dəyişdirildi.');
    }

    public function sign_out()
    {
        auth()->logout();
        request()->session()->flush();
        request()->session()->regenerate();
        return redirect()->route('homepage');
    }
}
