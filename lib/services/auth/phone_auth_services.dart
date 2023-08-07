import 'dart:convert';

import 'package:healthcare2050/Model/auth/auth_response_model.dart';
import 'package:healthcare2050/view/pages/notifications/notification_screen.dart';
import 'package:http/http.dart' as http;

import '../../Api/Api.dart';

Future<Map<String, dynamic>> getAuthOTP(String phoneNumber) async {
  var url = Uri.parse(entryMobileNoApi);
  var response = await http.post(url, body: {
    "MobileNumber": phoneNumber,
  });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return {"status": data['status'], 'message': data['message']};
  } else {
    return {"status": false, 'message': "no data"};
  }
}

Future<Map<String, dynamic>> verifyPhoneOTP(
    String otp, String mobileNumber,) async {
  var token = await NotificationScreenState().getTokenz();
  var url = Uri.parse(validOtpApi);
  var response = await http.post(
    url,
    body: {"Otp": otp, "MobileNumber": mobileNumber,"DeviceToken":token,"DeviceType":"2"},
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data['status'] == true) {
      var userData = AuthResponseModel.fromJson(data);
      return {"status": true, "data": userData};
    } else {
      return {"status": false, "message": "OTP not matched"};
    }
  }

  return {"status": false, "message": "OTP not matched"};
}
