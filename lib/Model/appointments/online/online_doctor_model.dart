// To parse this JSON data, do
//
//     final onlineDoctorsModel = onlineDoctorsModelFromJson(jsonString);

import 'dart:convert';

List<OnlineDoctorsModel> onlineDoctorsModelFromJson(String str) => List<OnlineDoctorsModel>.from(json.decode(str).map((x) => OnlineDoctorsModel.fromJson(x)));

String onlineDoctorsModelToJson(List<OnlineDoctorsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnlineDoctorsModel {
  OnlineDoctorsModel({
    this.id,
    this.fullName,
    this.education,
    this.designation,
    this.image,
    this.sepcializationName,
    this.teleConsult,
    this.videoConsult,
  });

  int? id;
  String? fullName;
  String? education;
  String? designation;
  String? image;
  String? sepcializationName;
  int? teleConsult;
  int? videoConsult;

  factory OnlineDoctorsModel.fromJson(Map<String, dynamic> json) => OnlineDoctorsModel(
    id: json["Id"],
    fullName: json["FullName"],
    education: json["Education"],
    designation: json["Designation"],
    image: json["Image"],
    sepcializationName: json["SepcializationName"],
    teleConsult: json["TeleConsult"],
    videoConsult: json["VideoConsult"] == null ? null : json["VideoConsult"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "FullName": fullName,
    "Education": education,
    "Designation": designation,
    "Image": image,
    "SepcializationName": sepcializationName,
    "TeleConsult": teleConsult,
    "VideoConsult": videoConsult == null ? null : videoConsult,
  };
}
