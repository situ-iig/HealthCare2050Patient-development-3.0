// To parse this JSON data, do
//
//     final appointmentHistoryModel = appointmentHistoryModelFromJson(jsonString);

import 'dart:convert';

AppointmentHistoryModel appointmentHistoryModelFromJson(String str) => AppointmentHistoryModel.fromJson(json.decode(str));

String appointmentHistoryModelToJson(AppointmentHistoryModel data) => json.encode(data.toJson());

class AppointmentHistoryModel {
  AppointmentHistoryModel({
    this.status,
    this.message,
    this.docSchedule,
  });

  bool? status;
  String? message;
  List<HistoryScheduleData>? docSchedule;

  factory AppointmentHistoryModel.fromJson(Map<String, dynamic> json) => AppointmentHistoryModel(
    status: json["status"],
    message: json["message"],
    docSchedule: List<HistoryScheduleData>.from(json["docSchedule"].map((x) => HistoryScheduleData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "docSchedule": List<dynamic>.from(docSchedule!.map((x) => x.toJson())),
  };
}

class HistoryScheduleData {
  HistoryScheduleData({
    this.patientName,
    this.mobileNumber,
    this.patientAge,
    this.sepcializationName,
    this.scheduleDate,
    this.doctorName,
    this.id,
    this.doctorId,
    this.userId,
    this.specializationId,
    this.status,
    this.consultationType,
    this.transactionId,
    this.isActive,
    this.createdBy,
    this.createdDateTime,
    this.updateBy,
    this.updatedDateTime,
    this.channelName,
    this.slotId,
  });

  String? patientName;
  String? mobileNumber;
  int? patientAge;
  String? sepcializationName;
  DateTime? scheduleDate;
  String? doctorName;
  int? id;
  int? doctorId;
  int? userId;
  int? specializationId;
  int? status;
  int? consultationType;
  dynamic transactionId;
  int? isActive;
  dynamic createdBy;
  DateTime? createdDateTime;
  dynamic updateBy;
  DateTime? updatedDateTime;
  String? channelName;
  int? slotId;

  factory HistoryScheduleData.fromJson(Map<String, dynamic> json) => HistoryScheduleData(
    patientName: json["PatientName"],
    mobileNumber: json["MobileNumber"],
    patientAge: json["PatientAge"],
    sepcializationName: json["SepcializationName"],
    scheduleDate: DateTime.parse(json["ScheduleDate"]),
    doctorName: json["DoctorName"],
    id: json["Id"],
    doctorId: json["DoctorId"],
    userId: json["UserId"],
    specializationId: json["SpecializationId"],
    status: json["Status"],
    consultationType: json["ConsultationType"],
    transactionId: json["TransactionId"],
    isActive: json["IsActive"],
    createdBy: json["CreatedBy"],
    createdDateTime: DateTime.parse(json["CreatedDateTime"]),
    updateBy: json["UpdateBy"],
    updatedDateTime: DateTime.parse(json["UpdatedDateTime"]),
    channelName: json["ChannelName"],
    slotId: json["SlotId"],
  );

  Map<String, dynamic> toJson() => {
    "PatientName": patientName,
    "MobileNumber": mobileNumber,
    "PatientAge": patientAge,
    "SepcializationName": sepcializationName,
    "ScheduleDate": "${scheduleDate?.year.toString().padLeft(4, '0')}-${scheduleDate?.month.toString().padLeft(2, '0')}-${scheduleDate?.day.toString().padLeft(2, '0')}",
    "DoctorName": doctorName,
    "Id": id,
    "DoctorId": doctorId,
    "UserId": userId,
    "SpecializationId": specializationId,
    "Status": status,
    "ConsultationType": consultationType,
    "TransactionId": transactionId,
    "IsActive": isActive,
    "CreatedBy": createdBy,
    "CreatedDateTime": createdDateTime?.toIso8601String(),
    "UpdateBy": updateBy,
    "UpdatedDateTime": updatedDateTime?.toIso8601String(),
    "ChannelName": channelName,
    "SlotId": slotId,
  };
}
