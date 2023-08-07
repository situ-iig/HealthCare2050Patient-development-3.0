// To parse this JSON data, do
//
//     final specializationDoctorListModel = specializationDoctorListModelFromJson(jsonString);

import 'dart:convert';

SpecializationDoctorListModel specializationDoctorListModelFromJson(String str) => SpecializationDoctorListModel.fromJson(json.decode(str));

String specializationDoctorListModelToJson(SpecializationDoctorListModel data) => json.encode(data.toJson());

class SpecializationDoctorListModel {
    SpecializationDoctorListModel({
      required  this.status,
      required  this.categoryDoctor,
    });

    bool status;
    List<CategoryDoctor> categoryDoctor;

    factory SpecializationDoctorListModel.fromJson(Map<String, dynamic> json) => SpecializationDoctorListModel(
        status: json["status"],
        categoryDoctor: List<CategoryDoctor>.from(json["categoryDoctor"].map((x) => CategoryDoctor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "categoryDoctor": List<dynamic>.from(categoryDoctor.map((x) => x.toJson())),
    };
}

class CategoryDoctor {
    CategoryDoctor({
      required  this.id,
      required  this.fullName,
      required  this.education,
      required  this.image,
      required  this.designation,
    });

    int id;
    String fullName;
    String education;
    String image;
    String designation;

    factory CategoryDoctor.fromJson(Map<String, dynamic> json) => CategoryDoctor(
        id: json["Id"],
        fullName: json["FullName"],
        education: json["Education"],
        image: json["Image"],
        designation: json["Designation"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "FullName": fullName,
        "Education": education,
        "Image": image,
        "Designation": designation,
    };
}
