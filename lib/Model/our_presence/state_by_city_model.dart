// To parse this JSON data, do
//
//     final stateByCityModel = stateByCityModelFromJson(jsonString);

import 'dart:convert';

List<StateByCityModel> stateByCityModelFromJson(String str) => List<StateByCityModel>.from(json.decode(str).map((x) => StateByCityModel.fromJson(x)));

String stateByCityModelToJson(List<StateByCityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateByCityModel {
  StateByCityModel({
    this.id,
    this.cityName,
  });

  int? id;
  String? cityName;

  factory StateByCityModel.fromJson(Map<String, dynamic> json) => StateByCityModel(
    id: json["Id"],
    cityName: json["CityName"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "CityName": cityName,
  };
}
