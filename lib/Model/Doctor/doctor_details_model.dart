// To parse this JSON data, do
//
//     final doctorDetailsModel = doctorDetailsModelFromJson(jsonString);

import 'dart:convert';

List<DoctorDetailsModel> doctorDetailsModelFromJson(String str) => List<DoctorDetailsModel>.from(json.decode(str).map((x) => DoctorDetailsModel.fromJson(x)));

String doctorDetailsModelToJson(List<DoctorDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorDetailsModel {
  DoctorDetailsModel({
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
    this.specializationId
  });

  int? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? education;
  String? designation;
  String? image;
  dynamic aboutDoctor;
  int? phone;
  int? otp;
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
  int? specializationId;

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) => DoctorDetailsModel(
    id: json["Id"],
    firstName: json["FirstName"],
    lastName: json["LastName"] == null ? null : json["LastName"],
    fullName: json["FullName"],
    education: json["Education"],
    designation: json["Designation"] == null ? null : json["Designation"],
    image: json["Image"],
    aboutDoctor: json["AboutDoctor"],
    phone: json["Phone"] == null ? null : json["Phone"],
    otp: json["OTP"] == null ? null : json["OTP"],
    emailId: json["EmailId"] == null ? null : json["EmailId"],
    address: json["Address"],
    dob: json["Dob"],
    onPayroll: json["OnPayroll"],
    consultant: json["Consultant"],
    teleConsult: json["TeleConsult"],
    videoConsult: json["VideoConsult"] == null ? null : json["VideoConsult"],
    doj: json["Doj"],
    dol: json["Dol"],
    anniversary: json["Anniversary"],
    createdBy: json["CreatedBy"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updatedBy: json["UpdatedBy"],
    updatedAt: DateTime.parse(json["UpdatedAt"]),
    isActive: json["IsActive"],
    isDeleted: json["IsDeleted"],
    specializationId: json['SpecId']
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "FirstName": firstName,
    "LastName": lastName == null ? null : lastName,
    "FullName": fullName,
    "Education": education,
    "Designation": designation == null ? null : designation,
    "Image": image,
    "AboutDoctor": aboutDoctor,
    "Phone": phone == null ? null : phone,
    "OTP": otp == null ? null : otp,
    "EmailId": emailId == null ? null : emailId,
    "Address": address,
    "Dob": dob,
    "OnPayroll": onPayroll,
    "Consultant": consultant,
    "TeleConsult": teleConsult,
    "VideoConsult": videoConsult == null ? null : videoConsult,
    "Doj": doj,
    "Dol": dol,
    "Anniversary": anniversary,
    "CreatedBy": createdBy,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedAt": updatedAt?.toIso8601String(),
    "IsActive": isActive,
    "IsDeleted": isDeleted,
    "SpecId":specializationId
  };
}
