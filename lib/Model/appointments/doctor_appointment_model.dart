// To parse this JSON data, do
//
//     final doctorAppointmentModel = doctorAppointmentModelFromJson(jsonString);

import 'dart:convert';

List<DoctorAppointmentModel> doctorAppointmentModelFromJson(String str) => List<DoctorAppointmentModel>.from(json.decode(str).map((x) => DoctorAppointmentModel.fromJson(x)));

String doctorAppointmentModelToJson(List<DoctorAppointmentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorAppointmentModel {
  DoctorAppointmentModel({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.education,
    this.designation,
    this.image,
    this.aboutDoctor,
    this.phone,
    this.otp,
    this.emailId,
    this.address,
    this.dob,
    this.onPayroll,
    this.consultant,
    this.teleConsult,
    this.videoConsult,
    this.doj,
    this.dol,
    this.anniversary,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.isActive,
    this.isDeleted,
    this.docSpecId,
    this.docterId,
    this.specId,
    this.createdDateTime,
    this.updatedDateTime,
    this.specializationId,
    this.cityId,
    this.sepcializationName,
    this.price,
    this.icon,
    this.docCityId,
    this.doctorId,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? education;
  String? designation;
  String? image;
  dynamic aboutDoctor;
  dynamic phone;
  dynamic otp;
  String? emailId;
  dynamic address;
  dynamic dob;
  dynamic onPayroll;
  dynamic consultant;
  int? teleConsult;
  int? videoConsult;
  dynamic doj;
  dynamic dol;
  dynamic anniversary;
  dynamic createdBy;
  DateTime? createdAt;
  dynamic updatedBy;
  DateTime? updatedAt;
  int? isActive;
  int? isDeleted;
  int? docSpecId;
  int? docterId;
  int? specId;
  DateTime? createdDateTime;
  DateTime? updatedDateTime;
  int? specializationId;
  int? cityId;
  String? sepcializationName;
  String? price;
  String? icon;
  int? docCityId;
  int? doctorId;

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) => DoctorAppointmentModel(
    id: json["Id"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    fullName: json["FullName"],
    education: json["Education"],
    designation: json["Designation"],
    image: json["Image"],
    aboutDoctor: json["AboutDoctor"],
    phone: json["Phone"],
    otp: json["OTP"],
    emailId: json["EmailId"],
    address: json["Address"],
    dob: json["Dob"],
    onPayroll: json["OnPayroll"],
    consultant: json["Consultant"],
    teleConsult: json["TeleConsult"],
    videoConsult: json["VideoConsult"],
    doj: json["Doj"],
    dol: json["Dol"],
    anniversary: json["Anniversary"],
    createdBy: json["CreatedBy"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updatedBy: json["UpdatedBy"],
    updatedAt: DateTime.parse(json["UpdatedAt"]),
    isActive: json["IsActive"],
    isDeleted: json["IsDeleted"],
    docSpecId: json["DocSpecId"],
    docterId: json["DocterId"],
    specId: json["SpecId"],
    createdDateTime: DateTime.parse(json["CreatedDateTime"]),
    updatedDateTime: DateTime.parse(json["UpdatedDateTime"]),
    specializationId: json["SpecializationId"],
    cityId: json["CityId"],
    sepcializationName: json["SepcializationName"],
    price: json["Price"],
    icon: json["Icon"],
    docCityId: json["DocCityId"],
    doctorId: json["DoctorId"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "FirstName": firstName,
    "LastName": lastName,
    "FullName": fullName,
    "Education": education,
    "Designation": designation,
    "Image": image,
    "AboutDoctor": aboutDoctor,
    "Phone": phone,
    "OTP": otp,
    "EmailId": emailId,
    "Address": address,
    "Dob": dob,
    "OnPayroll": onPayroll,
    "Consultant": consultant,
    "TeleConsult": teleConsult,
    "VideoConsult": videoConsult,
    "Doj": doj,
    "Dol": dol,
    "Anniversary": anniversary,
    "CreatedBy": createdBy,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedAt": updatedAt?.toIso8601String(),
    "IsActive": isActive,
    "IsDeleted": isDeleted,
    "DocSpecId": docSpecId,
    "DocterId": docterId,
    "SpecId": specId,
    "CreatedDateTime": createdDateTime?.toIso8601String(),
    "UpdatedDateTime": updatedDateTime?.toIso8601String(),
    "SpecializationId": specializationId,
    "CityId": cityId,
    "SepcializationName": sepcializationName,
    "Price": price,
    "Icon": icon,
    "DocCityId": docCityId,
    "DoctorId": doctorId,
  };
}
