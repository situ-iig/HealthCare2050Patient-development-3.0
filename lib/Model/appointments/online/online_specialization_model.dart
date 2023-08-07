// To parse this JSON data, do
//
//     final onlineSpecializationModel = onlineSpecializationModelFromJson(jsonString);

import 'dart:convert';

OnlineSpecializationModel onlineSpecializationModelFromJson(String str) => OnlineSpecializationModel.fromJson(json.decode(str));


class OnlineSpecializationModel {
  OnlineSpecializationModel({
    this.status,
    this.message,
    this.specializationData,
  });

  bool? status;
  String? message;
  List<OnlineSpecializationData>? specializationData;

  factory OnlineSpecializationModel.fromJson(Map<String, dynamic> json) => OnlineSpecializationModel(
    status: json["status"],
    message: json["message"],
    specializationData: List<OnlineSpecializationData>.from(json["SpecializationData"].map((x) => OnlineSpecializationData.fromJson(x))),
  );

}

class OnlineSpecializationData {
  OnlineSpecializationData({
    this.specializationId,
    this.cityId,
    this.sepcializationName,
    this.price,
    this.icon,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.createdDateTime,
    this.updatedBy,
    this.updatedDateTime,
  });

  int? specializationId;
  String? cityId;
  String? sepcializationName;
  String? price;
  String? icon;
  int? isActive;
  int? isDeleted;
  dynamic createdBy;
  DateTime? createdDateTime;
  dynamic updatedBy;
  DateTime? updatedDateTime;

  factory OnlineSpecializationData.fromJson(Map<String, dynamic> json) => OnlineSpecializationData(
    specializationId: json["SpecializationId"],
    cityId: json["CityId"],
    sepcializationName: json["SepcializationName"],
    price: json["Price"],
    icon: json["Icon"],
    isActive: json["IsActive"],
    isDeleted: json["IsDeleted"],
    createdBy: json["CreatedBy"],
    createdDateTime: DateTime.parse(json["CreatedDateTime"]),
    updatedBy: json["UpdatedBy"],
    updatedDateTime: DateTime.parse(json["UpdatedDateTime"]),
  );

}
