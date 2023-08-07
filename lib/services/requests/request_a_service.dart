
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Api/Api.dart';


class RequestAService {

  static Future<bool> sendRequestForService(String f_name,String l_name,String email, String service, String mobile,String cityId)async {
    final response = await http.post(
      Uri.parse(reuestAserviceApi.toString()),
      headers: <String, String>{
        'Accept': 'application/json'
      },
      body: {
        "FirstName": f_name,
        "LastName": l_name,
        "Email": email,
        "Service": service,
        "Mobile": mobile,
        "Cityid": cityId,
      },
    );

    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      if(resData['status'] == true){
        return true;
      }else{
        return false;
      }
    } else {
      throw Exception('Something went wrong');
    }
  }
}