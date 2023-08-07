// To parse this JSON data, do
//
//     final cityAppointmentModel = cityAppointmentModelFromJson(jsonString);

import 'dart:convert';

CityAppointmentModel cityAppointmentModelFromJson(String str) => CityAppointmentModel.fromJson(json.decode(str));


class CityAppointmentModel {
  CityAppointmentModel({
    this.status,
    this.cityname,
  });

  bool? status;
  List<Cityname>? cityname;

  factory CityAppointmentModel.fromJson(Map<String, dynamic> json) => CityAppointmentModel(
    status: json["status"],
    cityname: List<Cityname>.from(json["cityname"].map((x) => Cityname.fromJson(x))),
  );

}

class Cityname {
  Cityname({
    this.cityName,
    this.icon,
    this.id,
  });

  String? cityName;
  String? icon;
  int? id;

  factory Cityname.fromJson(Map<String, dynamic> json) => Cityname(
    cityName: json["CityName"],
    icon: json["Icon"],
    id: json["Id"],
  );

}
