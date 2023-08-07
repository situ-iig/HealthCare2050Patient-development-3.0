// To parse this JSON data, do
//
//     final reviewFeedbackListModel = reviewFeedbackListModelFromJson(jsonString);

import 'dart:convert';

List<ReviewFeedbackListModel> reviewFeedbackListModelFromJson(String str) => List<ReviewFeedbackListModel>.from(json.decode(str).map((x) => ReviewFeedbackListModel.fromJson(x)));

String reviewFeedbackListModelToJson(List<ReviewFeedbackListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewFeedbackListModel {
  ReviewFeedbackListModel({
    this.id,
    this.listName,
    this.createdDateTime,
    this.updatedDateTime,
  });

  int? id;
  String? listName;
  DateTime? createdDateTime;
  DateTime? updatedDateTime;

  factory ReviewFeedbackListModel.fromJson(Map<String, dynamic> json) => ReviewFeedbackListModel(
    id: json["Id"],
    listName: json["ListName"],
    createdDateTime: DateTime.parse(json["CreatedDateTime"]),
    updatedDateTime: DateTime.parse(json["UpdatedDateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ListName": listName,
    "CreatedDateTime": createdDateTime?.toIso8601String(),
    "UpdatedDateTime": updatedDateTime?.toIso8601String(),
  };
}
