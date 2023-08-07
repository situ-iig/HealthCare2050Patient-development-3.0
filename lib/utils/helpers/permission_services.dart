import 'package:permission_handler/permission_handler.dart';

class PermissionService{
   requestForPermission()async{
     Map<Permission, PermissionStatus> statuses = await [
     Permission.camera,
         Permission.microphone,
     ].request();

     if(await Permission.camera.status.isDenied){
       Permission.camera.request();
     }else if(await Permission.microphone.status.isDenied){
       Permission.microphone.request();
     }else{
       print("___permission___ granted");
     }
   }
}