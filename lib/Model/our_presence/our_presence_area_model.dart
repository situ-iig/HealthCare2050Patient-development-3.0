// To parse this JSON data, do
//
//     final ourPresenceAreaModel = ourPresenceAreaModelFromJson(jsonString);

import 'dart:convert';

OurPresenceAreaModel ourPresenceAreaModelFromJson(String str) => OurPresenceAreaModel.fromJson(json.decode(str));

String ourPresenceAreaModelToJson(OurPresenceAreaModel data) => json.encode(data.toJson());

class OurPresenceAreaModel {
  OurPresenceAreaModel({
    this.status,
    this.message,
    this.zoneWiseFetch,
  });

  bool? status;
  String? message;
  List<OurPresenceData>? zoneWiseFetch;

  factory OurPresenceAreaModel.fromJson(Map<String, dynamic> json) => OurPresenceAreaModel(
    status: json["status"],
    message: json["message"],
    zoneWiseFetch: List<OurPresenceData>.from(json["zoneWiseFetch"].map((x) => OurPresenceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "zoneWiseFetch": List<dynamic>.from(zoneWiseFetch!.map((x) => x.toJson())),
  };
}

class OurPresenceData {
  OurPresenceData({
    this.zoneId,
    this.zoneName,
    this.isActive,
    this.isDeleted,
  });

  int? zoneId;
  String? zoneName;
  int? isActive;
  int? isDeleted;

  factory OurPresenceData.fromJson(Map<String, dynamic> json) => OurPresenceData(
    zoneId: json["ZoneId"],
    zoneName: json["ZoneName"],
    isActive: json["IsActive"],
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "ZoneId": zoneId,
    "ZoneName": zoneName,
    "IsActive": isActive,
    "IsDeleted": isDeleted,
  };
}
