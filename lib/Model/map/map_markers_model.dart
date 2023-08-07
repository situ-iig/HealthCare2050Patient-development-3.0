// To parse this JSON data, do
//
//     final mapMarkersModel = mapMarkersModelFromJson(jsonString);

import 'dart:convert';

List<MapMarkersModel> mapMarkersModelFromJson(String str) => List<MapMarkersModel>.from(json.decode(str).map((x) => MapMarkersModel.fromJson(x)));

String mapMarkersModelToJson(List<MapMarkersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MapMarkersModel {
  MapMarkersModel({
    this.id,
    this.cityId,
    this.address,
    this.address1,
    this.address2,
    this.pincode,
    this.createdBy,
    this.createdAt,
    this.updateAt,
    this.updateBy,
    this.isActive,
    this.isDelete,
    this.latitude,
    this.longitude,
    this.colorcode,
    this.stateName,
    this.cityName,
  });

  int? id;
  int? cityId;
  String? address;
  String? address1;
  String? address2;
  int? pincode;
  dynamic createdBy;
  DateTime? createdAt;
  DateTime? updateAt;
  dynamic updateBy;
  int? isActive;
  int? isDelete;
  String? latitude;
  String? longitude;
  String? colorcode;
  String? stateName;
  String? cityName;

  factory MapMarkersModel.fromJson(Map<String, dynamic> json) => MapMarkersModel(
    id: json["Id"],
    cityId: json["CityId"],
    address: json["Address"],
    address1: json["Address1"],
    address2: json["Address2"] == null ? null : json["Address2"],
    pincode: json["Pincode"],
    createdBy: json["CreatedBy"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updateAt: DateTime.parse(json["UpdateAt"]),
    updateBy: json["UpdateBy"],
    isActive: json["IsActive"],
    isDelete: json["IsDelete"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
    colorcode: json["Colorcode"],
    stateName: json['StateName'],
    cityName: json["CityName"]
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "CityId": cityId,
    "Address": address,
    "Address1": address1,
    "Address2": address2 == null ? null : address2,
    "Pincode": pincode,
    "CreatedBy": createdBy,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdateAt": updateAt?.toIso8601String(),
    "UpdateBy": updateBy,
    "IsActive": isActive,
    "IsDelete": isDelete,
    "Latitude": latitude,
    "Longitude": longitude,
    "Colorcode": colorcode,
    "CityName":cityName,
    "StateName":stateName
  };
}
