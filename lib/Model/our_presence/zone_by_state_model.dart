// To parse this JSON data, do
//
//     final zoneByStateModel = zoneByStateModelFromJson(jsonString);

import 'dart:convert';

List<ZoneByStateModel> zoneByStateModelFromJson(String str) => List<ZoneByStateModel>.from(json.decode(str).map((x) => ZoneByStateModel.fromJson(x)));

String zoneByStateModelToJson(List<ZoneByStateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZoneByStateModel {
  ZoneByStateModel({
    this.id,
    this.stateName,
  });

  int? id;
  String? stateName;

  factory ZoneByStateModel.fromJson(Map<String, dynamic> json) => ZoneByStateModel(
    id: json["Id"],
    stateName: json["StateName"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "StateName": stateName,
  };
}
