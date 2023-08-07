
// To parse this JSON data, do
//
//     final authResponseModel = authResponseModelFromJson(jsonString);

import 'dart:convert';

AuthResponseModel authResponseModelFromJson(String str) => AuthResponseModel.fromJson(json.decode(str));

String authResponseModelToJson(AuthResponseModel data) => json.encode(data.toJson());

class AuthResponseModel {
  AuthResponseModel({
    this.status,
    this.message,
    this.appUserDetails,
    this.userDetails,
  });

  bool? status;
  String? message;
  AppUserDetails? appUserDetails;
  UserDetails? userDetails;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => AuthResponseModel(
    status: json["status"],
    message: json["message"],
    appUserDetails: AppUserDetails.fromJson(json["app_user_details"]),
    userDetails: UserDetails.fromJson(json["userDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "app_user_details": appUserDetails?.toJson(),
    "userDetails": userDetails?.toJson(),
  };
}

class AppUserDetails {
  AppUserDetails({
    this.userId,
    this.mobileNumber,
  });

  int? userId;
  String? mobileNumber;

  factory AppUserDetails.fromJson(Map<String, dynamic> json) => AppUserDetails(
    userId: json["user_id"],
    mobileNumber: json["MobileNumber"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "MobileNumber": mobileNumber,
  };
}

class UserDetails {
  UserDetails({
    this.id,
    this.fullName,
    this.email,
    this.mobileNumber,
    this.otp,
    this.address,
    this.city,
    this.state,
    this.image,
    this.pincode,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  dynamic fullName;
  String? email;
  String? mobileNumber;
  int? otp;
  String? address;
  String? city;
  String? state;
  String? image;
  String? pincode;
  dynamic password;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["Id"],
    fullName: json["FullName"],
    email: json["Email"],
    mobileNumber: json["MobileNumber"],
    otp: json["Otp"],
    address: json["Address"],
    city: json["City"],
    state: json["State"],
    image: json["Image"],
    pincode: json["Pincode"],
    password: json["Password"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updatedAt: DateTime.parse(json["UpdatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "FullName": fullName,
    "Email": email,
    "MobileNumber": mobileNumber,
    "Otp": otp,
    "Address": address,
    "City": city,
    "State": state,
    "Image": image,
    "Pincode": pincode,
    "Password": password,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
  };
}
