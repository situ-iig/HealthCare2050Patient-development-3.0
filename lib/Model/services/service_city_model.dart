// To parse this JSON data, do
//
//     final serviceCityModel = serviceCityModelFromJson(jsonString);

import 'dart:convert';

List<ServiceCityModel> serviceCityModelFromJson(String str) => List<ServiceCityModel>.from(json.decode(str).map((x) => ServiceCityModel.fromJson(x)));

String serviceCityModelToJson(List<ServiceCityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceCityModel {
  ServiceCityModel({
    this.id,
    this.zoneId,
    this.foreignStateId,
    this.cityName,
    this.icon,
    this.backgroundImage,
    this.galleryImageId,
    this.contactNo,
    this.createdBy,
    this.createdAt,
    this.updateBy,
    this.updateAt,
    this.isActive,
    this.isDelete,
  });

  int? id;
  int? zoneId;
  String? foreignStateId;
  String? cityName;
  String? icon;
  String? backgroundImage;
  String? galleryImageId;
  String? contactNo;
  int? createdBy;
  DateTime? createdAt;
  dynamic updateBy;
  DateTime? updateAt;
  int? isActive;
  int? isDelete;

  factory ServiceCityModel.fromJson(Map<String, dynamic> json) => ServiceCityModel(
    id: json["Id"],
    zoneId: json["ZoneId"],
    foreignStateId: json["ForeignStateId"],
    cityName: json["CityName"],
    icon: json["Icon"],
    backgroundImage: json["BackgroundImage"] == null ? null : json["BackgroundImage"],
    galleryImageId: json["GalleryImageId"] == null ? null : json["GalleryImageId"],
    contactNo: json["Contact_no"],
    createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updateBy: json["UpdateBy"],
    updateAt: DateTime.parse(json["UpdateAt"]),
    isActive: json["IsActive"],
    isDelete: json["IsDelete"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ZoneId": zoneId,
    "ForeignStateId": foreignStateId,
    "CityName": cityName,
    "Icon": icon,
    "BackgroundImage": backgroundImage == null ? null : backgroundImage,
    "GalleryImageId": galleryImageId == null ? null : galleryImageId,
    "Contact_no": contactNo,
    "CreatedBy": createdBy == null ? null : createdBy,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdateBy": updateBy,
    "UpdateAt": updateAt?.toIso8601String(),
    "IsActive": isActive,
    "IsDelete": isDelete,
  };
}
