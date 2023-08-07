import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/appointments/city_appointment_model.dart';
import 'package:healthcare2050/Model/appointments/slot_appointment_model.dart';
import 'package:healthcare2050/Model/appointments/specialist_appointment_model.dart';

import '../../Api/Api.dart';
import 'package:http/http.dart' as http;

import '../../Model/appointments/doctor_appointment_model.dart';
import '../../Model/patient/add_patient_details_model.dart';
import '../../utils/data/local_data_keys.dart';
import '../../utils/data/shared_preference.dart';

class OfflineAppointmentApi {
  Future<List<Cityname>> getAllCityData() async {
    var url = Uri.parse(CityNameApi);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var cityData = jsonDecode(response.body);
      if (cityData['status'] == true) {
        List cityList = cityData['cityname'];
        return cityList.map((e) => Cityname.fromJson(e)).toList();
      } else {
        return List<Cityname>.empty();
      }
    } else {
      return List<Cityname>.empty();
    }
  }

  Future<List<SpecializationName>> getSpecialistByCityName(
      String cityId) async {
    var url = Uri.parse(cityBasedSpecializationApi);
    var response = await http.post(url, body: {"CityId": cityId});
    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      if (resData['status'] == true) {
        List specialistList = resData['SpecializationName'];
        return specialistList
            .map((e) => SpecializationName.fromJson(e))
            .toList();
      } else {
        return List<SpecializationName>.empty();
      }
    } else {
      return List<SpecializationName>.empty();
    }
  }

  Future<List<DoctorAppointmentModel>> getDoctorBySpecialization(
      String cityId, String specialId) async {
    var url = Uri.parse(specializationBasedDoctorsApi);
    var response =
        await http.post(url, body: {"cityId": cityId, "specialId": specialId});
    if (response.statusCode == 200) {
      List resData = jsonDecode(response.body);
      if (resData.isNotEmpty) {
        List specialistList = resData;
        return specialistList
            .map((e) => DoctorAppointmentModel.fromJson(e))
            .toList();
      } else {
        return List<DoctorAppointmentModel>.empty();
      }
    } else {
      return List<DoctorAppointmentModel>.empty();
    }
  }

  Future<bool> postDataToOfflineDoctorConsult(
      BuildContext context, AddPatientDetailsModel data) async {
    final response = await http.post(
      Uri.parse(bookDoctorAppointmentApi),
      headers: <String, String>{'Accept': 'application/json'},
      body: {
        "DoctorId": data.doctorId,
        "UserId": data.userId,
        "SpecializationId": data.specializationId,
        "PatientName": data.patientName,
        "PatientAge": data.patientAge,
        "MobileNumber": data.patientMobile,
        "ScheduleDate": data.consultDate,
        "SlotId": data.slotId,
        "ConsultationType": data.consultType,
        "gender": data.patientGender,
        "CityId": data.cityId,
        "Pincode": "000000"
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<Map<String, dynamic>> getPaymentId() async {
    var userId = await getStringFromLocal(userIdKey);
    var response = await http
        .post(Uri.parse(oderIdApi.toString()), body: {"UserId": userId});
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      if (items['status'] == true) {
        var scheduleId = items['OrderId'].toString();
        return {"0": true, "1": scheduleId};
        //goToRazorpayPaymentProcess(scheduleId);
      } else {
        return {"0": false};
      }
    } else {
      return {"0": false};
    }
  }

  Future<bool> updatePaymentDetails(String paymentId, String orderId) async {
    var response = await http.post(Uri.parse(updateRazorPayApi.toString()),
        headers: <String, String>{},
        body: {"RazorpayId": orderId, "paymentId": paymentId});
    if (response.statusCode == 200) {
      bool database_status = json.decode(response.body)['status'] ?? false;

      if (database_status == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

class SlotsAppointmentProvider with ChangeNotifier {
  List<AvailableSlot> _slots = <AvailableSlot>[];

  List<AvailableSlot> get allSlots => _slots;
  String _payableAmount = "0";
  String get payableAmount => _payableAmount;

  getAvailableDoctorSlot(String date, String doctorId, String specialId) async {
    var showZoneWiseStateList_url = offlineBookAppointmentApi;
    var response = await http.post(Uri.parse(showZoneWiseStateList_url),
        headers: <String, String>{},
        body: {"date": date, "docid": doctorId, "specializationId": specialId});
    if (response.statusCode == 200) {
      var resData = json.decode(response.body);
      var status = resData['status'];

      if (status == true) {
        List items = resData['available_slot'];
        var amount = resData['Price'];
        _payableAmount = amount.toString();
        _slots = items.map((e) => AvailableSlot.fromJson(e)).toList();
        notifyListeners();
      } else {
        notifyListeners();
        _slots = List<AvailableSlot>.empty();
      }
    } else {
      notifyListeners();
      _slots = List<AvailableSlot>.empty();
    }
  }
}
