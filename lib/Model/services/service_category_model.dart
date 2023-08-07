// To parse this JSON data, do
//
//     final serviceCotegoryModel = serviceCotegoryModelFromJson(jsonString);

import 'dart:convert';

List<ServiceCategoryModel> serviceCotegoryModelFromJson(String str) => List<ServiceCategoryModel>.from(json.decode(str).map((x) => ServiceCategoryModel.fromJson(x)));

String serviceCotegoryModelToJson(List<ServiceCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceCategoryModel {
  ServiceCategoryModel({
    this.id,
    this.cityId,
    this.categoryName,
    this.description,
    this.content,
    this.categoryMobileContent,
    this.icon,
    this.image,
    this.backgroundImage,
    this.createdBy,
    this.createdAt,
    this.updateAt,
    this.updateBy,
    this.isActive,
    this.isDelete,
    this.subcategory,
  });

  int? id;
  String? cityId;
  String? categoryName;
  String? description;
  String? content;
  dynamic categoryMobileContent;
  String? icon;
  String? image;
  String? backgroundImage;
  dynamic createdBy;
  DateTime? createdAt;
  DateTime? updateAt;
  dynamic updateBy;
  int? isActive;
  int? isDelete;
  List<ServiceSubcategory>?subcategory;

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) => ServiceCategoryModel(
    id: json["Id"],
    cityId: json["CityId"],
    categoryName: json["CategoryName"],
    description: json["Description"],
    content: json["Content"],
    categoryMobileContent: json["CategoryMobileContent"],
    icon: json["Icon"],
    image: json["Image"],
    backgroundImage: json["BackgroundImage"],
    createdBy: json["CreatedBy"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updateAt: DateTime.parse(json["UpdateAt"]),
    updateBy: json["UpdateBy"],
    isActive: json["IsActive"],
    isDelete: json["IsDelete"],
    subcategory: List<ServiceSubcategory>.from(json["subcategory"].map((x) => ServiceSubcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "CityId": cityId,
    "CategoryName": categoryName,
    "Description": description,
    "Content": content,
    "CategoryMobileContent": categoryMobileContent,
    "Icon": icon,
    "Image": image,
    "BackgroundImage": backgroundImage,
    "CreatedBy": createdBy,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdateAt": updateAt?.toIso8601String(),
    "UpdateBy": updateBy,
    "IsActive": isActive,
    "IsDelete": isDelete,
    "subcategory": List<dynamic>.from(subcategory!.map((x) => x.toJson())),
  };
}

class ServiceSubcategory {
  ServiceSubcategory({
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

  factory ServiceSubcategory.fromJson(Map<String, dynamic> json) => ServiceSubcategory(
    id: json["Id"],
    categoryId: json["CategoryId"],
    subcategoryName: json["SubcategoryName"],
    headerName: json["HeaderName"] == null ? null : json["HeaderName"],
    description: json["Description"] == null ? null : json["Description"],
    subcategoryContent: json["SubcategoryContent"] == null ? null : json["SubcategoryContent"],
    subcategoryUrl: json["SubcategoryUrl"] == null ? null : json["SubcategoryUrl"],
    subcategoryMobileContent: json["SubcategoryMobileContent"] == null ? null : json["SubcategoryMobileContent"],
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
    "HeaderName": headerName == null ? null : headerName,
    "Description": description == null ? null : description,
    "SubcategoryContent": subcategoryContent == null ? null : subcategoryContent,
    "SubcategoryUrl": subcategoryUrl == null ? null : subcategoryUrl,
    "SubcategoryMobileContent": subcategoryMobileContent == null ? null : subcategoryMobileContent,
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
