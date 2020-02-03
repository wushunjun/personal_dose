<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;

class UploadController extends Controller
{
    /**
     * 图片上传视图页面
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $func = $request->func;
        $path = $request->path ?? 'home';
        $fileType = $request->fileType ?? 'Images'; //上传文件类型，视频，图片
        $image_upload_limit_size = 2;
        if($fileType == 'Flash'){
            $upload = route('upload.videoUp',array('savepath'=>$path));
            $type = 'mp4,3gp,flv,avi,wmv';
        }else{
            $upload = route('upload.imageUp',array('savepath'=>$path));
            $type = 'jpg,png,gif,jpeg';
        }
        $info = array(
            'num'=> $request->num,
            'fileType'=> $fileType,
            'title' => '',
            'upload' =>$upload,
            //'fileList'=>U('Admin/Uploadify/fileList',array('path'=>$path)),
            'size' => $image_upload_limit_size.'M',
            'type' =>$type,
            'input' => $request->input,
            'func' => empty($func) ? 'undefined' : $func,
        );
        return view('admin.upload.index', compact('info'));
    }
    /**
     * 图片上传提交页面
     * @param Request $request
     */
    public function imageUp(Request $request)
    {
        //如果存在图片上传
        if ($request->hasFile('file') && $request->file('file')->isValid()) {
            $file = $request->file('file');
            $filename = md5($file->getFilename()) . rand(1000,10000) . '.' . $file->getClientOriginalExtension();
            //$filename = $request->file('file')->store('home');
            $filename = Storage::putFileAs($request->savepath,$file,$filename,'public');
            if ($filename) {
                return response()->json([
                    'state' => 'SUCCESS',
                    'url' => '/storage/' . $filename,
                ]);
            }else{
                $msg = '上传失败';
            }
        }else{
            $msg = '没有文件上传';
        }
        return response()->json([
            'state' => $msg,
        ],400);
    }

    /**
     * 删除图片
     * @param Request $request
     */
    public function delupload(Request $request){
        if($request->action == 'del'){
            $filename = str_replace('/storage','',$request->filename);
            Storage::exists($filename) && Storage::delete($filename);
        }
        echo 1;
    }
}
