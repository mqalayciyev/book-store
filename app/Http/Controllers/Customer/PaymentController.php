<?php

namespace App\Http\Controllers\Customer;

use App\Http\Controllers\Controller;
use App\Mail\InvoiceSend;
use App\Mail\OrderStatus;
use App\Models\Order;
use App\User;
use DB;
use App\Models\Cart as CartModel;
use App\Models\CartProduct;
use App\Models\Product;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Support\Facades\Mail;



class PaymentController extends Controller
{
    public function index()
    {
        if (!auth()->check()) {
            return redirect()->route('user.sign_in')
                ->with('message_type', 'info')
                ->with('message', __('content.You need to log in or register for a payment.'));
        } else if (count(Cart::content()) == 0) {
            return redirect()->route('homepage')
                ->with('message_type', 'info')
                ->with('message', __('content.You must have a product in your cart for payment.'));
        }

        $user_detail = auth()->user()->detail;

        return view('customer.pages.payment', compact('user_detail'));
    }

    public function pay()
    {
        $this->validate(request(), [
            'first_name' => 'required',
            'last_name' => 'required',
            'email' => 'required',
            'mobile' => 'required',
            'country' => 'required',
            'city' => 'required',
            'address' => 'required',
            'zip_code' => 'required',
        ]);

        $paymentMethod =  request('payment_method');
        $order = request()->all();

        if($paymentMethod == 1){
            $order['bank'] = 'Payment at the door';
        }
        elseif($paymentMethod == 2){
            $order['bank'] = 'Bank Transfer';
        }
        
        $order['cart_id'] = session('active_cart_id');
        $order['installment_number'] = 1;
        $order['status'] =  'Your order has been received';
        $order['order_amount'] = Cart::subtotal();
        $user = User::where('id', auth()->id())->first();

        Order::create($order);
        
        $cart = CartModel::where('id', session('active_cart_id'))->first();
        $data =[
            'total_amount' => Cart::subtotal(),
            'payment_status' => __('content.Your order has been received'),
            'order_date' => date('Y-m-d H:i:s'),
            'payment_date' => date('Y-m-d H:i:s'),
            'client_firstname' => $order['first_name'],
            'client_lastname' => $order['last_name'],
            'client_email' => $user->email,
            'client_tel' => $order['mobile'],
            'client_address' => $order['address'],
            'discount' => '',
            'order_items' => $cart->cart_products,
        ];
        
        
        // Mail::to($user->email)->send(new InvoiceSend($data));
        
        Cart::destroy();
        session()->forget('active_cart_id');
        
        return redirect()->route('orders')
            ->with('message_type', 'success')
            ->with('message', __('content.Your payment has been successful.'));
    }
}
