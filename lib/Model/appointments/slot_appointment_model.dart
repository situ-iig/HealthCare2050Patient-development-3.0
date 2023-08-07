// To parse this JSON data, do
//
//     final slotAppointmentModel = slotAppointmentModelFromJson(jsonString);

import 'dart:convert';

SlotAppointmentModel slotAppointmentModelFromJson(String str) => SlotAppointmentModel.fromJson(json.decode(str));

String slotAppointmentModelToJson(SlotAppointmentModel data) => json.encode(data.toJson());

class SlotAppointmentModel {
  SlotAppointmentModel({
    this.status,
    this.title,
    this.price,
    this.availableSlot,
  });

  bool? status;
  String? title;
  String? price;
  List<AvailableSlot>? availableSlot;

  factory SlotAppointmentModel.fromJson(Map<String, dynamic> json) => SlotAppointmentModel(
    status: json["status"],
    title: json["title"],
    price: json["Price"],
    availableSlot: List<AvailableSlot>.from(json["available_slot"].map((x) => AvailableSlot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "title": title,
    "Price": price,
    "available_slot": List<dynamic>.from(availableSlot!.map((x) => x.toJson())),
  };
}

class AvailableSlot {
  AvailableSlot({
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

  factory AvailableSlot.fromJson(Map<String, dynamic> json) => AvailableSlot(
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

