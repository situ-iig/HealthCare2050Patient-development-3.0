// To parse this JSON data, do
//
//     final upcomingAppointmentsModel = upcomingAppointmentsModelFromJson(jsonString);

import 'dart:convert';

UpcomingAppointmentsModel upcomingAppointmentsModelFromJson(String str) => UpcomingAppointmentsModel.fromJson(json.decode(str));


class UpcomingAppointmentsModel {
  UpcomingAppointmentsModel({
    this.status,
    this.docSchedule,
  });

  bool? status;
  List<UpcomingScheduleModel>? docSchedule;

  factory UpcomingAppointmentsModel.fromJson(Map<String, dynamic> json) => UpcomingAppointmentsModel(
    status: json["status"],
    docSchedule: List<UpcomingScheduleModel>.from(json["docSchedule"].map((x) => UpcomingScheduleModel.fromJson(x))),
  );

}

class UpcomingScheduleModel {
  UpcomingScheduleModel({
    this.patientName,
    this.mobileNumber,
    this.patientAge,
    this.sepcializationName,
    this.scheduleDate,
    this.doctorName,
    this.startTime,
    this.endTime,
    this.id,
    this.doctorId,
    this.userId,
    this.specializationId,
    this.status,
    this.consultationType,
    this.transactionId,
    this.isActive,
    this.channelName,
    this.slotId,
  });

  String? patientName;
  String? mobileNumber;
  int? patientAge;
  String? sepcializationName;
  DateTime? scheduleDate;
  String? doctorName;
  String? startTime;
  String? endTime;
  int? id;
  int? doctorId;
  int? userId;
  int? specializationId;
  int? status;
  int? consultationType;
  String? transactionId;
  int? isActive;
  String? channelName;
  int? slotId;

  factory UpcomingScheduleModel.fromJson(Map<String, dynamic> json) => UpcomingScheduleModel(
    patientName: json["PatientName"],
    mobileNumber: json["MobileNumber"],
    patientAge: json["PatientAge"],
    sepcializationName: json["SepcializationName"],
    scheduleDate: json['ScheduleDate'] != null?DateTime.parse(json["ScheduleDate"]):DateTime.now(),
    doctorName: json["DoctorName"],
    startTime: json["StartTime"],
    endTime: json["EndTime"],
    id: json["Id"],
    doctorId: json["DoctorId"],
    userId: json["UserId"],
    specializationId: json["SpecializationId"],
    status: json["Status"],
    consultationType: json["ConsultationType"],
    transactionId: json["TransactionId"] == null ? null : json["TransactionId"],
    isActive: json["IsActive"],
    channelName: json["ChannelName"],
    slotId: json["SlotId"],
  );

}
