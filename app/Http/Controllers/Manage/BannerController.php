<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use App\Models\Banner;
use Illuminate\Http\Request;
use Image;
use Yajra\DataTables\Facades\DataTables;

class BannerController extends Controller
{
    public function index()
    {
        return view('manage.pages.banner.index');
    }

    public function index_data()
    {
        $rows = Banner::select(['banners.*']);

        return DataTables::eloquent($rows)
            ->editColumn('banner_image', function ($row) {
                $image = '<img src="';
                $image .= $row->banner_image != null ? asset("img/banners/" . $row->banner_image) : "http://via.placeholder.com/69x50?text=BannerPhoto(360x260)";
                $image .= '" class="img-responsive" style="width: 130px; min-width: 100%; height: auto;">';
                return $image;
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
                <a href="' . route('manage.banner.edit', $row->id) . '" class="btn btn-sm btn-primary edit"> <i class="fa fa-edit"></i> ' . __('admin.Edit') . '</a>
                <a href="javascript:void(0);" class="btn btn-sm btn-danger delete" style="display: ' . $disabled .'" id="' . $row->id . '"> <i class="fa fa-remove"></i> ' . __('admin.Delete') . '</a>
                </div>';
            })
            ->addColumn('checkbox', '<input type="checkbox" name="checkbox[]" id="checkbox" class="checkbox" value="{{$id}}" />')
            ->rawColumns(['checkbox', 'banner_image', 'action'])
            ->toJson();
    }

    public function form($id = null)
    {
        $flight = new Banner;
        if ($id > 0) {
            $flight = Banner::find($id);
        }
        return view('manage.pages.banner.form', compact('flight'));
    }

    public function save($id = null)
    {
        $data = request()->only('banner_slug', 'banner_active');
        $this->validate(request(), [
            'banner_slug' => 'required',
        ]);

        
        if (request()->hasFile('image')) {
            $image = request()->file('image');
            $image = request()->file('image');
            $image = request()->image;
            
            $filename = 'banner_' . time().'.webp';
            
            $path = public_path('img/banners/' . $filename);
            $square = Image::canvas(570, 210, array(255, 255, 255));

            $img = Image::make($image->getRealPath())
                    ->resize(570, null, function ($constraint) {
                    $constraint->aspectRatio();
            });
            $square->insert($img, 'center');
            $square->save($path);
            
            $data['banner_image'] = $filename;
        }
        if ($id > 0) {
            $flight = Banner::find($id);
            $flight->update($data);
        } else {
            $data['banner_order'] = Banner::where('deleted_at', null)->count() + 1;
            $flight = Banner::create($data);
        }
        return redirect()
            ->route('manage.banner.edit', $flight->id)
            ->with('message_icon', 'check')
            ->with('message_type', 'success')
            ->with('message', $id ? __('admin.Updated') : __('admin.Saved'));
    }

    public function delete_data(Request $request)
    {
        $rows = Banner::find($request->input('id'));
        if ($rows->forceDelete()) {
            echo __('admin.Data Deleted');
        }
    }

    public function mass_remove(Request $request)
    {
        $id_array = $request->input('id');
        $rows = Banner::whereIn('id', $id_array);
        if ($rows->forceDelete()) {
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
            $flight = Banner::find($id);
            $flight->banner_order = $index;
            $flight->save();
        }
    }
}
