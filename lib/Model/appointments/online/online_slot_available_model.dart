// To parse this JSON data, do
//
//     final onlineSlotAvailableModel = onlineSlotAvailableModelFromJson(jsonString);

import 'dart:convert';

OnlineSlotAvailableModel onlineSlotAvailableModelFromJson(String str) => OnlineSlotAvailableModel.fromJson(json.decode(str));

String onlineSlotAvailableModelToJson(OnlineSlotAvailableModel data) => json.encode(data.toJson());

class OnlineSlotAvailableModel {
  OnlineSlotAvailableModel({
    this.status,
    this.title,
    this.price,
    this.availableSlot,
  });

  bool? status;
  String? title;
  int? price;
  List<OnlineAvailableSlotData>? availableSlot;

  factory OnlineSlotAvailableModel.fromJson(Map<String, dynamic> json) => OnlineSlotAvailableModel(
    status: json["status"],
    title: json["title"],
    price: json["Price"],
    availableSlot: List<OnlineAvailableSlotData>.from(json["available_slot"].map((x) => OnlineAvailableSlotData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "title": title,
    "Price": price,
    "available_slot": List<dynamic>.from(availableSlot!.map((x) => x.toJson())),
  };
}

class OnlineAvailableSlotData {
  OnlineAvailableSlotData({
    this.doctorAvailableId,
    this.doctorId,
    this.days,
    this.startTime,
    this.endTime,
    this.isActive,
    this.isDeleted,
    this.slotActive,
  });

  int? doctorAvailableId;
  int? doctorId;
  String? days;
  String? startTime;
  String? endTime;
  int? isActive;
  int? isDeleted;
  int? slotActive;

  factory OnlineAvailableSlotData.fromJson(Map<String, dynamic> json) => OnlineAvailableSlotData(
    doctorAvailableId: json["DoctorAvailableId"],
    doctorId: json["DoctorId"],
    days: json["Days"],
    startTime: json["StartTime"],
    endTime: json["EndTime"],
    isActive: json["IsActive"],
    isDeleted: json["IsDeleted"],
    slotActive: json["SlotActive"],
  );

  Map<String, dynamic> toJson() => {
    "DoctorAvailableId": doctorAvailableId,
    "DoctorId": doctorId,
    "Days": days,
    "StartTime": startTime,
    "EndTime": endTime,
    "IsActive": isActive,
    "IsDeleted": isDeleted,
    "SlotActive": slotActive,
  };
}

