<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use App\Models\Slider;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Image;
use Yajra\DataTables\Facades\DataTables;

class SlideshowController extends Controller
{
    public function index()
    {
        return view('manage.pages.slideshow.index');
    }

    public function index_data()
    {
        $rows = Slider::select(['sliders.*']);

        return DataTables::eloquent($rows)
            ->editColumn('slider_image', function ($row) {
                $image = '<img src="';
                $image .= $row->slider_image != null ? asset("img/sliders/" . $row->slider_image) : "http://via.placeholder.com/1580x50?text=SliderPhoto(1140x360)";
                $image .= '" class="img-responsive" style="width: 130px; min-width: 100%; height: auto;">';
                return $image;
            })
            ->addColumn('slider_active', function ($row) {
                if($row->slider_active == 1){
                    $bg = "success";
                }else{
                    $bg = "default";
                }
                
                $output = '<span class="label label-' . $bg . '">';
                
                if($row->slider_active == 1){
                    $output .= "Aktiv";
                }
                else{
                    $output .= "Passiv";
                }
                $output .= '</span>';
                return $output;
            })
            ->addColumn('action', function ($row) {
                if(auth('manage')->user()->is_manage == 2){
                    $disabled = 'none';
                }
                else{
                    $disabled = '';
                }
                return '<div>
                <input type="hidden" name="sort_order" id="sort_order" value="' . $row->id . '"/>
                <a href="' . route('manage.slider.edit', $row->id) . '" class="btn  btn-sm btn-primary edit"> <i class="fa fa-edit"></i> ' . __('admin.Edit') . '</a>
                <a href="javascript:void(0);" class="btn btn-sm btn-danger delete" style="display: ' . $disabled .'" id="' . $row->id . '"> <i class="fa fa-remove"></i> ' . __('admin.Delete') . '</a>
                </div>';
            })
            ->addColumn('checkbox', '<input type="checkbox" name="checkbox[]" id="checkbox" class="checkbox" value="{{$id}}" />')
            ->rawColumns(['checkbox', 'slider_image', 'action', 'slider_active'])
            ->toJson();
    }

    public function form($id = null)
    {
        $flight = new Slider;
        if ($id > 0) {
            $flight = Slider::find($id);
        }
        return view('manage.pages.slideshow.form', compact('flight'));
    }

    public function save()
    {
        
        $validator = Validator::make(request()->all(), [
            'slider_slug' => 'required'
        ]);
        if ($validator->fails()) {
            return response()->json(['status' => 'error', 'message' => 'Link boş ola bilməz']);
        }

        $id = request('id');
        $data = request()->only('slider_slug', 'slider_active');
        if(request()->hasFile('image')){
            $image = request()->file('image');
            $image = request()->image;
            
            $filename = 'slider_' . time().'.webp';
            
            $path = public_path('img/sliders/' . $filename);
            $square = Image::canvas(1600, 600, array(255, 255, 255));

            $img = Image::make($image->getRealPath())
                    ->resize(1600, null, function ($constraint) {
                    $constraint->aspectRatio();
            });
            $square->insert($img, 'center');
            $square->save($path);


            $data['slider_image'] = $filename;
            $path = asset('img/sliders/' . $filename);
        }
        else{
            $path = "";
        }
        
        if ($id > 0) {
            $flight = Slider::find($id);
            $flight->update($data);
            $message = 'Məlumat yeniləndi';
        } else {
            $data['slider_order'] = Slider::where('deleted_at', null)->count() + 1;
            $flight = Slider::create($data);
            $message = 'Məlumat əlavə edildi';
        }
        
        return response()->json(['status' => 'success', 'message' => $message, 'url' => $path]);
        
    }
    public function delete_data(Request $request)
    {
        $rows = Slider::find($request->input('id'));
        if ($rows->delete()) {
            echo __('admin.Data Deleted');
        }
    }

    public function mass_remove(Request $request)
    {
        $id_array = $request->input('id');
        $rows = Slider::whereIn('id', $id_array);
        if ($rows->delete()) {
            echo __('admin.Data Deleted');
        }
    }

    public function reorder()
    {
        $serialize = request('serialize');
        $ids = explode("&sort_order=", $serialize);
        foreach ($ids as $index => $id) {
            if ($index == 0) {
                continue;
            }
            $id = (int)$id;
            $flight = Slider::find($id);
            $flight->slider_order = $index;
            $flight->save();
        }
    }
}
