import 'dart:convert';

import 'package:healthcare2050/Model/active_appointments/active_appointment_model.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:http/http.dart' as http;

import '../../Api/Api.dart';
import '../../Model/appointments/online/online_slot_available_model.dart';
import '../../Model/patient/add_patient_details_model.dart';
import '../../utils/data/shared_preference.dart';

class ActiveAppointmentsAPIs {
  Future<List<ActiveAppointmentModel>> getOnlineActiveAppointments(
      String consultType) async {
    var userId = await getStringFromLocal(userIdKey);
    var url = Uri.parse(onlineActiveAppointmentAPi);
    var response = await http.post(url,
        body: {"UserId": userId, "ConsultationType": consultType},
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      if (resData['status'] == true) {
        List data = resData['AllDataDetails'];
        return data.map((e) => ActiveAppointmentModel.fromJson(e)).toList();
      } else {
        return List<ActiveAppointmentModel>.empty();
      }
    } else {
      return List<ActiveAppointmentModel>.empty();
    }
  }


  Future<List<OnlineAvailableSlotData>> getAvailableSlots(
      String date, int doctorId, String consultType) async {
    var url = Uri.parse(DoctorSlotApi);
    var response = await http.post(url, body: {
      "date": date,
      "docid": doctorId.toString(),
      "ConsultType": consultType
    });
    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      if (resData['status'] == true && resData['available_slot'] != []) {
        List data = resData['available_slot'];
        return data.map((e) => OnlineAvailableSlotData.fromJson(e)).toList();
      } else {
        return List<OnlineAvailableSlotData>.empty();
      }
    } else {
      return List<OnlineAvailableSlotData>.empty();
    }
  }


  Future<bool> addPatientDetailsForOnlineConsultation(
    AddPatientDetailsModel data,String bookingId,String transactionId,
  ) async {
    final response = await http.post(
      Uri.parse(reInsertAppointmentDetailsApi.toString()),
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
        "Pincode": data.pinCode,
        "ParentBookingId":bookingId,
        "TransactionId":transactionId
      },
    );

    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      return resData['status'];
    } else {
      throw Exception('Something went wrong');
    }
  }
}
