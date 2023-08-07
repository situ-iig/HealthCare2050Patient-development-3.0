// To parse this JSON data, do
//
//     final todayConsultationModel = todayConsultationModelFromJson(jsonString);

import 'dart:convert';

TodayConsultationModel todayConsultationModelFromJson(String str) => TodayConsultationModel.fromJson(json.decode(str));

String todayConsultationModelToJson(TodayConsultationModel data) => json.encode(data.toJson());

class TodayConsultationModel {
  TodayConsultationModel({
    this.status,
    this.todayvideoConsultGet,
  });

  bool? status;
  List<TodayVideoConsultModel>? todayvideoConsultGet;

  factory TodayConsultationModel.fromJson(Map<String, dynamic> json) => TodayConsultationModel(
    status: json["status"],
    todayvideoConsultGet: List<TodayVideoConsultModel>.from(json["todayvideoConsultGet"].map((x) => TodayVideoConsultModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "todayvideoConsultGet": List<dynamic>.from(todayvideoConsultGet!.map((x) => x.toJson())),
  };
}

class TodayVideoConsultModel {
  TodayVideoConsultModel({
    this.patientName,
    this.mobileNumber,
    this.patientAge,
    this.sepcializationName,
    this.doctorName,
    this.scheduleDate,
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
    this.createdBy,
    this.createdDateTime,
    this.updateBy,
    this.updatedDateTime,
    this.channelName,
    this.slotId,
    this.currentDate,
    this.currentTime,
    this.scheduleDateTime,
    this.currentDateTime,
    this.address
  });

  String? patientName;
  String? mobileNumber;
  int? patientAge;
  String? sepcializationName;
  String? doctorName;
  DateTime? scheduleDate;
  String? startTime;
  String? endTime;
  int? id;
  int? doctorId;
  int? userId;
  int? specializationId;
  dynamic status;
  int? consultationType;
  String? transactionId;
  int? isActive;
  dynamic createdBy;
  DateTime? createdDateTime;
  dynamic updateBy;
  DateTime? updatedDateTime;
  String? channelName;
  int? slotId;
  String? currentDate;
  String? currentTime;
  String? scheduleDateTime;
  String? currentDateTime;
  String? address;

  factory TodayVideoConsultModel.fromJson(Map<String, dynamic> json) => TodayVideoConsultModel(
    patientName: json["PatientName"],
    mobileNumber: json["MobileNumber"],
    patientAge: json["PatientAge"],
    sepcializationName: json["SepcializationName"],
    doctorName: json["DoctorName"],
    scheduleDate: DateTime.parse(json["ScheduleDate"]),
    startTime: json["StartTime"],
    endTime: json["EndTime"],
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
    currentDate: json["CurrentDate"],
    currentTime: json["CurrentTime"],
    scheduleDateTime: json["ScheduleDateTime"],
    currentDateTime: json["CurrentDateTime"],
    address:json['Addressdata']
  );

  Map<String, dynamic> toJson() => {
    "PatientName": patientName,
    "MobileNumber": mobileNumber,
    "PatientAge": patientAge,
    "SepcializationName": sepcializationName,
    "DoctorName": doctorName,
    "ScheduleDate": "${scheduleDate?.year.toString().padLeft(4, '0')}-${scheduleDate?.month.toString().padLeft(2, '0')}-${scheduleDate?.day.toString().padLeft(2, '0')}",
    "StartTime": startTime,
    "EndTime": endTime,
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
    "CurrentDate": currentDate,
    "CurrentTime": currentTime,
    "ScheduleDateTime": scheduleDateTime,
    "CurrentDateTime": currentDateTime,
    "Addressdata":address
  };
}
