import 'dart:convert';

import 'package:healthcare2050/Api/Api.dart';
import 'package:http/http.dart' as http;

 Future<Map<String,dynamic>>getPrescriptionPdf(String scheduleId)async{
   var url = Uri.parse(getPrescriptionApi);
   var response = await http.post(url,body: {"id":scheduleId});
   if(response.statusCode == 200){
     var resData = jsonDecode(response.body);
     if(resData['status'] == true){
       return {'status':true,"url":resData['Precription']};
     }else{
       return {"status":false};
     }
   }else{
     return {"status":false};
   }
 }