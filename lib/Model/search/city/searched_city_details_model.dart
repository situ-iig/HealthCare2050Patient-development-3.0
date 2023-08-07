// To parse this JSON data, do
//
//     final searchedCityDetailsModel = searchedCityDetailsModelFromJson(jsonString);

import 'dart:convert';

SearchedCityDetailsModel searchedCityDetailsModelFromJson(String str) => SearchedCityDetailsModel.fromJson(json.decode(str));

String searchedCityDetailsModelToJson(SearchedCityDetailsModel data) => json.encode(data.toJson());

class SearchedCityDetailsModel {
  SearchedCityDetailsModel({
    this.status,
    this.title,
    this.cityName,
    this.backgroundImage,
    this.contact,
    this.allcityFetch,
    this.sevicename,
    this.doctorDetail,
  });

  bool? status;
  String? title;
  String? cityName;
  String? backgroundImage;
  SearchedCityContactDetails? contact;
  List<SearchedCityList>?allcityFetch;
  List<SearchedServiceNameList>? sevicename;
  List<SearchedDoctorDetailsList>? doctorDetail;

  factory SearchedCityDetailsModel.fromJson(Map<String, dynamic> json) => SearchedCityDetailsModel(
    status: json["status"],
    title: json["title"],
    cityName: json["CityName"],
    backgroundImage: json["BackgroundImage"],
    contact: SearchedCityContactDetails.fromJson(json["contact"]),
    allcityFetch: json['AllcityFetch'] == null?null:List<SearchedCityList>.from(json["AllcityFetch"].map((x) => SearchedCityList.fromJson(x))),
    sevicename: json["sevicename"] == null?null:List<SearchedServiceNameList>.from(json["sevicename"].map((x) => SearchedServiceNameList.fromJson(x))),
    doctorDetail: json["doctorDetail"] == null?null:List<SearchedDoctorDetailsList>.from(json["doctorDetail"].map((x) => SearchedDoctorDetailsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "title": title,
    "CityName": cityName,
    "BackgroundImage": backgroundImage,
    "contact": contact?.toJson(),
    "AllcityFetch": List<dynamic>.from(allcityFetch!.map((x) => x.toJson())),
    "sevicename": List<dynamic>.from(sevicename!.map((x) => x.toJson())),
    "doctorDetail": List<dynamic>.from(doctorDetail!.map((x) => x.toJson())),
  };
}

class SearchedCityList {
  SearchedCityList({
    this.id,
    this.cityName,
  });

  int? id;
  String? cityName;

  factory SearchedCityList.fromJson(Map<String, dynamic> json) => SearchedCityList(
    id: json["Id"],
    cityName: json["CityName"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "CityName": cityName,
  };
}

class SearchedCityContactDetails {
  SearchedCityContactDetails({
    this.address,
    this.address1,
    this.address2,
    this.cityName,
    this.stateName,
    this.pincode,
    this.contact_no
  });

  String? address;
  String? address1;
  String? address2;
  int? pincode;
  String? cityName;
  String? stateName;
  String? contact_no;

  factory SearchedCityContactDetails.fromJson(Map<String, dynamic> json) => SearchedCityContactDetails(
    address: json["Address"],
    address1: json["Address1"],
    address2: json["Address2"],
    cityName: json['CityName'],
    stateName: json['StateName'],
    pincode: json["Pincode"],
    contact_no: json['Contact_no']
  );

  Map<String, dynamic> toJson() => {
    "Address": address,
    "Address1": address1,
    "Address2": address2,
    "Pincode": pincode,
    "Contact_no":contact_no
  };
}

class SearchedDoctorDetailsList {
  SearchedDoctorDetailsList({
    this.fullName,
    this.education,
    this.image,
  });

  String? fullName;
  String? education;
  String? image;

  factory SearchedDoctorDetailsList.fromJson(Map<String, dynamic> json) => SearchedDoctorDetailsList(
    fullName: json["FullName"],
    education: json["Education"],
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "FullName": fullName,
    "Education": education,
    "Image": image,
  };
}


class SearchedServiceNameList {
  SearchedServiceNameList({
    this.id,
    this.categoryName,
    this.icon,
    this.description,
  });

  int? id;
  String? categoryName;
  String? icon;
  String? description;

  factory SearchedServiceNameList.fromJson(Map<String, dynamic> json) => SearchedServiceNameList(
    id: json["Id"],
    categoryName: json["CategoryName"],
    icon: json["Icon"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "CategoryName": categoryName,
    "Icon": icon,
    "Description": description,
  };
}

