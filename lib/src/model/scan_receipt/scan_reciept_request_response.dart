// To parse this JSON data, do
//
//     final scanReceiptRequestResponse = scanReceiptRequestResponseFromJson(jsonString);

import 'dart:convert';

ScanReceiptRequestResponse scanReceiptRequestResponseFromJson(String str) => ScanReceiptRequestResponse.fromJson(json.decode(str));

String scanReceiptRequestResponseToJson(ScanReceiptRequestResponse data) => json.encode(data.toJson());

class ScanReceiptRequestResponse {
  bool? success;
  int? statusCode;
  Data? data;
  String? message;
  String? messageArabic;

  ScanReceiptRequestResponse({
    this.success,
    this.statusCode,
    this.data,
    this.message,
    this.messageArabic,
  });

  factory ScanReceiptRequestResponse.fromJson(Map<String, dynamic> json) => ScanReceiptRequestResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    messageArabic: json["message_arabic"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data?.toJson(),
    "message": message,
    "message_arabic": messageArabic,
  };
}

class Data {
  int? totalPoints;
  int? letsCollectPoints;
  int? partnerPoint;
  int? brandPoint;
  int? pointId;

  Data({
    this.totalPoints,
    this.letsCollectPoints,
    this.partnerPoint,
    this.brandPoint,
    this.pointId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalPoints: json["total_points"],
    letsCollectPoints: json["lets_collect_points"],
    partnerPoint: json["partner_point"],
    brandPoint: json["brand_point"],
    pointId: json["point_id"],
  );

  Map<String, dynamic> toJson() => {
    "total_points": totalPoints,
    "lets_collect_points": letsCollectPoints,
    "partner_point": partnerPoint,
    "brand_point": brandPoint,
    "point_id": pointId,
  };
}
