// To parse this JSON data, do
//
//     final serviceSubCategoryModel = serviceSubCategoryModelFromJson(jsonString);

import 'dart:convert';

List<ServiceSubCategoryModel> serviceSubCategoryModelFromJson(String str) => List<ServiceSubCategoryModel>.from(json.decode(str).map((x) => ServiceSubCategoryModel.fromJson(x)));

String serviceSubCategoryModelToJson(List<ServiceSubCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceSubCategoryModel {
  ServiceSubCategoryModel({
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
  String? subcategoryUrl;
  String? subcategoryMobileContent;
  String? icon;
  String? image;
  String? subBackgroundImage;
  String? subcategoryTitle;
  dynamic createdBy;
  DateTime? createdAt;
  dynamic updateBy;
  DateTime? updateAt;
  int? isActive;
  int? isDeleted;

  factory ServiceSubCategoryModel.fromJson(Map<String, dynamic> json) => ServiceSubCategoryModel(
    id: json["Id"],
    categoryId: json["CategoryId"],
    subcategoryName: json["SubcategoryName"],
    headerName: json["HeaderName"],
    description: json["Description"],
    subcategoryContent: json["SubcategoryContent"],
    subcategoryUrl: json["SubcategoryUrl"] == null ? null : json["SubcategoryUrl"],
    subcategoryMobileContent: json["SubcategoryMobileContent"],
    icon: json["Icon"],
    image: json["Image"] == null ? null : json["Image"],
    subBackgroundImage: json["SubBackgroundImage"],
    subcategoryTitle: json["SubcategoryTitle"] == null ? null : json["SubcategoryTitle"],
    createdBy: json["CreatedBy"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updateBy: json["UpdateBy"],
    updateAt: DateTime.parse(json["UpdateAt"]),
    isActive: json["IsActive"],
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "CategoryId": categoryId,
    "SubcategoryName": subcategoryName,
    "HeaderName": headerName,
    "Description": description,
    "SubcategoryContent": subcategoryContent,
    "SubcategoryUrl": subcategoryUrl == null ? null : subcategoryUrl,
    "SubcategoryMobileContent": subcategoryMobileContent,
    "Icon": icon,
    "Image": image == null ? null : image,
    "SubBackgroundImage": subBackgroundImage,
    "SubcategoryTitle": subcategoryTitle == null ? null : subcategoryTitle,
    "CreatedBy": createdBy,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdateBy": updateBy,
    "UpdateAt": updateAt?.toIso8601String(),
    "IsActive": isActive,
    "IsDeleted": isDeleted,
  };
}
