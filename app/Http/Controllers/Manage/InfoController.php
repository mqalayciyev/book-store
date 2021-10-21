<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use App\Models\Info;
use Illuminate\Http\Request;
use Image;


class InfoController extends Controller
{
    public function index(){
        return view('manage.pages.info.index');
    }
    public function save(Request $request)
    {
        $data = $request->except('_token', 'logo');
        $update = Info::find(1);
        $update->update($data);
        if (request()->hasFile('logo')) {
            $logo = request()->file('logo');
            $filename = 'logo-' . time() . '.' . $logo->extension();
            $path = public_path('img/' . $filename);
            $rectangle = Image::canvas(230, 173, array(255, 255, 255, 0));
            $img_rec = Image::make($logo->getRealPath())
                ->resize(230, null, function ($constraint) {
                    $constraint->aspectRatio();
                });
            $rectangle->insert($img_rec, 'center');
            $rectangle->save($path);
            
            Info::find(1)->update([
                'logo' => $filename
            ]);

        }
        
        if ($update) {
            $request->session()->flash('message_icon', 'check');
            $request->session()->flash('message_type', 'success');
            $request->session()->flash('message', 'Məlumat yeniləndi');
        } else {
            $request->session()->flash('message_icon', 'warning');
            $request->session()->flash('message_type', 'warning');
            $request->session()->flash('message', 'Xəta! Zəhmət olmasa bir daha cəhd edin');
        }
        return back();
    }
}
