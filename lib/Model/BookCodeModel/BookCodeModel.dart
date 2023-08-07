// To parse this JSON data, do
//
//     final bookCodeModel = bookCodeModelFromJson(jsonString);

import 'dart:convert';

BookCodeModel bookCodeModelFromJson(String str) => BookCodeModel.fromJson(json.decode(str));

String bookCodeModelToJson(BookCodeModel data) => json.encode(data.toJson());

class BookCodeModel {
    BookCodeModel({
       this.status,
        this.message,
        this.bookingCode,
    });

    bool? status;
    String? message;
    String? bookingCode;

    factory BookCodeModel.fromJson(Map<String, dynamic> json) => BookCodeModel(
        status: json["status"],
        message: json["message"],
        bookingCode: json["BookingCode"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "BookingCode": bookingCode,
    };
}
