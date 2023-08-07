// To parse this JSON data, do
//
//     final activeAppointmentModel = activeAppointmentModelFromJson(jsonString);

import 'dart:convert';

ActiveAppointmentModel activeAppointmentModelFromJson(String str) => ActiveAppointmentModel.fromJson(json.decode(str));

String activeAppointmentModelToJson(ActiveAppointmentModel data) => json.encode(data.toJson());

class ActiveAppointmentModel {
  ActiveAppointmentModel({
    this.doctorId,
    this.userId,
    this.doctorName,
    this.specializationId,
    this.slotId,
    this.cityId,
    this.consultationType,
    this.image,
    this.specializationName,
    this.qualification,
    this.patientName,
    this.patientAge,
    this.patientGender,
    this.pincode,
    this.patientMobileNumber,
    this.scheduleDate,
    this.completedScheduleDate,
    this.razorpayId,
    this.paymentId,
    this.address,
    this.bookScheduleId,
    this.transactionId
  });

  int? doctorId;
  int? userId;
  String? doctorName;
  int? specializationId;
  int? slotId;
  int? cityId;
  int? consultationType;
  String? image;
  String? specializationName;
  String? qualification;
  String? patientName;
  int? patientAge;
  String? patientGender;
  int? pincode;
  String? patientMobileNumber;
  DateTime? scheduleDate;
  DateTime? completedScheduleDate;
  String? razorpayId;
  String? paymentId;
  String? address;
  int? bookScheduleId;
  String? transactionId;

  factory ActiveAppointmentModel.fromJson(Map<String, dynamic> json) => ActiveAppointmentModel(
    doctorId: json["DoctorId"],
    userId: json["UserId"],
    doctorName: json["DoctorName"],
    specializationId: json["SpecializationId"],
    slotId: json["SlotId"],
    cityId: json["CityId"],
    consultationType: json["ConsultationType"],
    image: json["Image"],
    specializationName: json["SpecializationName"],
    qualification: json["Qualification"],
    patientName: json["PatientName"],
    patientAge: json["PatientAge"],
    patientGender: json["PatientGender"],
    pincode: json["Pincode"],
    patientMobileNumber: json["PatientMobileNumber"],
    scheduleDate: json["ScheduleDate"] == null ? null : DateTime.parse(json["ScheduleDate"]),
    completedScheduleDate: json["CompletedScheduleDate"] == null ? null : DateTime.parse(json["CompletedScheduleDate"]),
    razorpayId: json["RazorpayId"],
    paymentId: json["paymentId"],
    address: json['Address'],
    bookScheduleId: json['BookSchduleId'],
    transactionId: json['TransactionId']
  );

  Map<String, dynamic> toJson() => {
    "DoctorId": doctorId,
    "UserId": userId,
    "DoctorName": doctorName,
    "SpecializationId": specializationId,
    "SlotId": slotId,
    "CityId": cityId,
    "ConsultationType": consultationType,
    "Image": image,
    "SpecializationName": specializationName,
    "Qualification": qualification,
    "PatientName": patientName,
    "PatientAge": patientAge,
    "PatientGender": patientGender,
    "Pincode": pincode,
    "PatientMobileNumber": patientMobileNumber,
    "ScheduleDate": "${scheduleDate!.year.toString().padLeft(4, '0')}-${scheduleDate!.month.toString().padLeft(2, '0')}-${scheduleDate!.day.toString().padLeft(2, '0')}",
    "CompletedScheduleDate": "${completedScheduleDate!.year.toString().padLeft(4, '0')}-${completedScheduleDate!.month.toString().padLeft(2, '0')}-${completedScheduleDate!.day.toString().padLeft(2, '0')}",
    "RazorpayId": razorpayId,
    "paymentId": paymentId,
  };
}
