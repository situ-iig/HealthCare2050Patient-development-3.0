import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/history/appointment_history_model.dart';
import 'package:healthcare2050/Model/history/today_appointment_model.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:http/http.dart' as http;

import '../Api/Api.dart';
import '../Model/history/upcomming_appointment_model.dart';

class HistoryAppointmentProvider with ChangeNotifier{
  List<TodayVideoConsultModel> _todayAppointment = <TodayVideoConsultModel>[];
  List<TodayVideoConsultModel> get todayAppointments => _todayAppointment;

  List<UpcomingScheduleModel> _upcomingAppointment = <UpcomingScheduleModel>[];
  List<UpcomingScheduleModel> get upcomingAppointment => _upcomingAppointment;

  bool _loader = true;
  bool get loader =>_loader;
  
  Future<void> getTodayAppointments(String consultType)async{
    _loader = true;
    var userId = await getStringFromLocal(userIdKey);
    var url = Uri.parse(todayAppointmentsApi);
    var response = await http.post(url,body: {"patientId":userId,"consultType":consultType});
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _loader = false;
      if(data['status'] == true){
        List appointments = data['todayvideoConsultGet'];
        _todayAppointment = appointments.map((e) => TodayVideoConsultModel.fromJson(e)).toList();
        notifyListeners();
      }else{
        _loader = false;
        _todayAppointment = List<TodayVideoConsultModel>.empty();
        notifyListeners();
      }
      notifyListeners();
    }else{
      _loader = false;
      _todayAppointment = List<TodayVideoConsultModel>.empty();
      notifyListeners();
    }
  }


  Future<void> getUpcomingAppointments(String type)async{
    var userId = await getStringFromLocal(userIdKey);
    var url = Uri.parse(upcomingAppointmentsApi);
    var response = await http.post(url,body: {"Id":userId,"consultType":type});
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      _loader = false;
      if(data['status'] == true){
        List appointments = data['docSchedule'];
        _upcomingAppointment = appointments.map((e) => UpcomingScheduleModel.fromJson(e)).toList();
        notifyListeners();
      }else{
        _upcomingAppointment = List<UpcomingScheduleModel>.empty();
        notifyListeners();
      }
    }else{
      _loader = false;
      _upcomingAppointment = List<UpcomingScheduleModel>.empty();
      notifyListeners();
    }
  }

  Future<List<HistoryScheduleData>> getHistoryAppointments(String consultType)async{
    var userId = await getStringFromLocal(userIdKey);
    var url = Uri.parse(doctorAppointmentScheduleListApi).replace(
        queryParameters: {"Id": userId,"consultType":consultType});
    // var a = "https://2050healthcare.com/public/api/auth/doctorScheduleList?Id=$userId&consultType=";
    var response = await http.get(url);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      if(data['status'] == true){
        List appointments = data['docSchedule'];
        return appointments.map((e) => HistoryScheduleData.fromJson(e)).toList();

      }else{
        notifyListeners();
        return List<HistoryScheduleData>.empty();
      }
    }else{
      notifyListeners();
      return List<HistoryScheduleData>.empty();
    }
  }
  
}