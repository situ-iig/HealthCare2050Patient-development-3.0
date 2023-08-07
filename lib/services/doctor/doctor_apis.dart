import 'dart:convert';

import 'package:healthcare2050/Model/Doctor/doctor_details_model.dart';
import 'package:http/http.dart' as http;
import '../../Api/Api.dart';

class DoctorApis {
  Future<List<DoctorDetailsModel>> getAllDoctorList() async {
    var url = Uri.parse(doctorApi);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      if (data != []) {
        return data.map((e) => DoctorDetailsModel.fromJson(e)).toList();
      } else {
        return List<DoctorDetailsModel>.empty();
      }
    } else {
      return List<DoctorDetailsModel>.empty();
    }
  }
}
