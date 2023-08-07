// To parse this JSON data, do
//
//     final allDoctorScheduleModel = allDoctorScheduleModelFromJson(jsonString);

import 'dart:convert';

AllDoctorScheduleModel allDoctorScheduleModelFromJson(String str) => AllDoctorScheduleModel.fromJson(json.decode(str));

String allDoctorScheduleModelToJson(AllDoctorScheduleModel data) => json.encode(data.toJson());

class AllDoctorScheduleModel {
    AllDoctorScheduleModel({
      required  this.status,
      required  this.title,
      required  this.message,
      required  this.bookingDetail,
    });

    bool status;
    String title;
    String message;
    BookingDetail bookingDetail;

    factory AllDoctorScheduleModel.fromJson(Map<String, dynamic> json) => AllDoctorScheduleModel(
        status: json["status"],
        title: json["title"],
        message: json["message"],
        bookingDetail: BookingDetail.fromJson(json["BookingDetail"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "title": title,
        "message": message,
        "BookingDetail": bookingDetail.toJson(),
    };
}

class BookingDetail {
    BookingDetail({
      required  this.patientName,
      required  this.mobileNumber,
      required  this.scheduleDate,
      required  this.userId,
      required  this.doctorId,
      required  this.patientAge,
    });

    String patientName;
    String mobileNumber;
    String scheduleDate;
    String userId;
    String doctorId;
    String patientAge;

    factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
        patientName: json["PatientName"],
        mobileNumber: json["MobileNumber"],
        scheduleDate: json["ScheduleDate"],
        userId: json["UserId"],
        doctorId: json["DoctorId"],
        patientAge: json["PatientAge"],
    );

    Map<String, dynamic> toJson() => {
        "PatientName": patientName,
        "MobileNumber": mobileNumber,
        "ScheduleDate": scheduleDate,
        "UserId": userId,
        "DoctorId": doctorId,
        "PatientAge": patientAge,
    };
}
