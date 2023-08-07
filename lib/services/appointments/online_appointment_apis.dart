import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:healthcare2050/Model/patient/add_patient_details_model.dart';
import 'package:http/http.dart' as http;
import '../../Api/Api.dart';
import '../../Model/appointments/online/online_doctor_model.dart';
import '../../Model/appointments/online/online_slot_available_model.dart';
import '../../Model/appointments/online/online_specialization_model.dart';
import '../../utils/data/local_data_keys.dart';
import '../../utils/data/shared_preference.dart';

class OnlineAppointmentsApis {
  Future<List<OnlineSpecializationData>> getOnlineSpecializations() async {
    var url = Uri.parse(specializationApi);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      if (resData['status'] == true) {
        List data = resData['SpecializationData'];
        return data.map((e) => OnlineSpecializationData.fromJson(e)).toList();
      } else {
        return List<OnlineSpecializationData>.empty();
      }
    } else {
      return List<OnlineSpecializationData>.empty();
    }
  }

  Future<List<OnlineDoctorsModel>> getOnlineDoctors(String id) async {
    var url = Uri.parse(specializationWiseDoctorApi);
    var response = await http.post(url, body: {"SpecializationId": id});
    if (response.statusCode == 200) {
      List resData = jsonDecode(response.body);
      if (resData != []) {
        return resData.map((e) => OnlineDoctorsModel.fromJson(e)).toList();
      } else {
        return List<OnlineDoctorsModel>.empty();
      }
    } else {
      return List<OnlineDoctorsModel>.empty();
    }
  }

  Future<bool> addPatientDetailsForOnlineConsultation(
      AddPatientDetailsModel data,

  ) async {
    final response = await http.post(
      Uri.parse(bookDoctorAppointmentApi.toString()),
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
        "CityId": "0",
        "Pincode":data.pinCode
      },
    );

    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      return resData['status'];
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<Map<String, dynamic>> generatePayment() async {
    var userId = await getStringFromLocal(userIdKey);

    var response = await http
        .post(Uri.parse(oderIdApi.toString()), body: {"UserId": userId});
    if (response.statusCode == 200) {
      var resData = json.decode(response.body);
      print(resData);
      var status = resData['status'];
      var orderId = resData['OrderId'];
      return {'status': status, 'id': orderId};
    } else {
      return {'status': false};
    }
  }

  Future<Map<String, dynamic>> goToRazorpayPaymentProcess(
      String scheduleId, String amount) async {
    var userId = await getStringFromLocal(userIdKey);
    print("schedule id $scheduleId");
    var response =
        await http.post(Uri.parse(goToRazorPayApi.toString()), body: {
      "userId": userId,
      "bookscheduleid": scheduleId,
      "amount": amount,
    });
    if (response.statusCode == 200) {
      var items = json.decode(response.body); 
      print(items);
      if (items['status'] == true) {
        var status = items['status'];
        var orderId = items['orderId'];
        return {'status': status, 'orderId': orderId};
      } else {
        return {'status': false};
      }
    } else {
      return {'status': false};
    }
  }

  Future<bool> submitPaymentDetails(String orderId, String paymentId) async {
    var response = await http.post(Uri.parse(updateRazorPayApi.toString()),
        headers: <String, String>{},
        body: {"RazorpayId": orderId, "paymentId": paymentId});
    if (response.statusCode == 200) {
      var items = json.decode(response.body);

      if (items['status'] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

class OnlineAvailableSlotProvider with ChangeNotifier {

  String _appointmentFee = "";
  String get appointmentFee => _appointmentFee;

  List<OnlineAvailableSlotData> _slotList = <OnlineAvailableSlotData>[];

  List<OnlineAvailableSlotData> get slotList => _slotList;

  onlineSlots(String date, String doctorId, String consultType) async {
    var url = Uri.parse(DoctorSlotApi);
    var response = await http.post(url,
        body: {"date": date, "docid": doctorId, "ConsultType": consultType});
    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      if (resData['status'] == true && resData['available_slot'] != []) {
        _appointmentFee = resData['Price'].toString();
        var data = OnlineSlotAvailableModel.fromJson(resData);
        _slotList = data.availableSlot ?? <OnlineAvailableSlotData>[];
        notifyListeners();
      } else {
        _slotList = List<OnlineAvailableSlotData>.empty();
        notifyListeners();
      }
    } else {
      _slotList = List<OnlineAvailableSlotData>.empty();
      notifyListeners();
    }
  }

  Future<void> getOnlineSlots(String date, String doctorId, String consultType){
    return onlineSlots(date,doctorId,consultType);
  }
}
