import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Api/Api.dart';

class VideoConsultationApis {
  Future<bool> endTheCall(String scheduleId) async {
    var url = Uri.parse(callEndApi);
    var response = await http.post(url, body: {"bookscheduleid": scheduleId});
    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      bool callEndStatus = resData['status'];
      if (callEndStatus == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
