// To parse this JSON data, do
//
//     final specialistAppointmentModel = specialistAppointmentModelFromJson(jsonString);

import 'dart:convert';

SpecialistAppointmentModel specialistAppointmentModelFromJson(String str) => SpecialistAppointmentModel.fromJson(json.decode(str));

String specialistAppointmentModelToJson(SpecialistAppointmentModel data) => json.encode(data.toJson());

class SpecialistAppointmentModel {
  SpecialistAppointmentModel({
    this.status,
    this.specializationName,
  });

  bool? status;
  List<SpecializationName>? specializationName;

  factory SpecialistAppointmentModel.fromJson(Map<String, dynamic> json) => SpecialistAppointmentModel(
    status: json["status"],
    specializationName: List<SpecializationName>.from(json["SpecializationName"].map((x) => SpecializationName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "SpecializationName": List<dynamic>.from(specializationName!.map((x) => x.toJson())),
  };
}

class SpecializationName {
  SpecializationName({
    this.specializationId,
    this.sepcializationName,
    this.icon,
    this.price,
  });

  int? specializationId;
  String? sepcializationName;
  String? icon;
  String? price;

  factory SpecializationName.fromJson(Map<String, dynamic> json) => SpecializationName(
    specializationId: json["SpecializationId"],
    sepcializationName: json["SepcializationName"],
    icon: json["Icon"],
    price: json["Price"],
  );

  Map<String, dynamic> toJson() => {
    "SpecializationId": specializationId,
    "SepcializationName": sepcializationName,
    "Icon": icon,
    "Price": price,
  };
}
