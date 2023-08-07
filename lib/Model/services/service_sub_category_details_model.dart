// To parse this JSON data, do
//
//     final serviceSubCategoryDetailsModel = serviceSubCategoryDetailsModelFromJson(jsonString);

import 'dart:convert';

ServiceSubCategoryDetailsModel serviceSubCategoryDetailsModelFromJson(String str) => ServiceSubCategoryDetailsModel.fromJson(json.decode(str));

String serviceSubCategoryDetailsModelToJson(ServiceSubCategoryDetailsModel data) => json.encode(data.toJson());

class ServiceSubCategoryDetailsModel {
  ServiceSubCategoryDetailsModel({
    this.status,
    this.message,
    this.categoryData,
  });

  bool? status;
  String? message;
  ServiceSubCategoryData? categoryData;

  factory ServiceSubCategoryDetailsModel.fromJson(Map<String, dynamic> json) => ServiceSubCategoryDetailsModel(
    status: json["status"],
    message: json["message"],
    categoryData: ServiceSubCategoryData.fromJson(json["SubactegoryListing"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "CategoryData": categoryData?.toJson(),
  };
}

class ServiceSubCategoryData {
  ServiceSubCategoryData({
    this.id,
    this.categoryId,
    this.subcategoryName,
    this.headerName,
    this.description,
    this.subcategoryContent,
    this.subcategoryUrl,
    this.subcategoryMobileContent,
    this.icon,
    this.image,
    this.subBackgroundImage,
    this.subcategoryTitle,
    this.createdBy,
    this.createdAt,
    this.updateBy,
    this.updateAt,
    this.isActive,
    this.isDeleted,
  });

  int? id;
  int? categoryId;
  String? subcategoryName;
  String? headerName;
  String? description;
  String? subcategoryContent;
  dynamic subcategoryUrl;
  String? subcategoryMobileContent;
  String? icon;
  dynamic image;
  String? subBackgroundImage;
  dynamic subcategoryTitle;
  dynamic createdBy;
  DateTime? createdAt;
  dynamic updateBy;
  DateTime? updateAt;
  int? isActive;
  int? isDeleted;

  factory ServiceSubCategoryData.fromJson(Map<String, dynamic> json) => ServiceSubCategoryData(
    id: json["Id"],
    categoryId: json["CategoryId"],
    subcategoryName: json["SubcategoryName"],
    headerName: json["HeaderName"],
    description: json["Description"],
    subcategoryContent: json["SubcategoryContent"],
    subcategoryUrl: json["SubcategoryUrl"] == null?null:json["SubcategoryUrl"],
    subcategoryMobileContent: json["SubcategoryMobileContent"] == null?null:json["SubcategoryMobileContent"],
    icon: json["Icon"],
    image: json["Image"] == null?null:json["Image"],
    subBackgroundImage: json["SubBackgroundImage"] == null?null:json["SubBackgroundImage"],
    subcategoryTitle: json["SubcategoryTitle"] == null?null:json["SubcategoryTitle"],
    createdBy: json["CreatedBy"] == null?null:json["CreatedBy"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updateBy: json["UpdateBy"] == null?null:json["UpdateBy"],
    updateAt: DateTime.parse(json["UpdateAt"]),
    isActive: json["IsActive"] == null?null:json["IsActive"],
    isDeleted: json["IsDeleted"] == null?null:json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "CategoryId": categoryId,
    "SubcategoryName": subcategoryName,
    "HeaderName": headerName,
    "Description": description,
    "SubcategoryContent": subcategoryContent,
    "SubcategoryUrl": subcategoryUrl,
    "SubcategoryMobileContent": subcategoryMobileContent,
    "Icon": icon,
    "Image": image,
    "SubBackgroundImage": subBackgroundImage,
    "SubcategoryTitle": subcategoryTitle,
    "CreatedBy": createdBy,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdateBy": updateBy,
    "UpdateAt": updateAt?.toIso8601String(),
    "IsActive": isActive,
    "IsDeleted": isDeleted,
  };
}
