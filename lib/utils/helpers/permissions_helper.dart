import 'package:permission_handler/permission_handler.dart';

//import 'package:agora_uikit/agora_uikit.dart';


Future<bool> requestCamera({required Function? onGranted()})async{
  if(await Permission.camera.isDenied || await Permission.camera.isRestricted){
    await Permission.camera.request();
    return true;
  }else if(await Permission.microphone.isDenied || await Permission.microphone.isRestricted){
    await Permission.microphone.request();
    return true;
  }else{
    return false;
  }
}

requestForCameraAndMic({dynamic onGranted})async{
  var camera = Permission.camera;
  if(await camera.status.isDenied){
    camera.request();
    //requestMicPermission(onGranted);
  }else{
    requestMicPermission(onGranted);
  }
}

requestMicPermission(Function onGranted())async{
  var mic = Permission.microphone;
  if(await mic.status.isDenied){
    mic.request();
    onGranted();
  }else{
    onGranted();
  }
}