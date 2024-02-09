
import 'dart:convert';

ScanReceiptRequestResponse scanReceiptRequestResponseFromJson(String str) => ScanReceiptRequestResponse.fromJson(json.decode(str));

String scanReceiptRequestResponseToJson(ScanReceiptRequestResponse data) => json.encode(data.toJson());

class ScanReceiptRequestResponse {
  bool? success;
  Data? data;
  String? message;

  ScanReceiptRequestResponse({
    this.success,
    this.data,
    this.message,
  });

  factory ScanReceiptRequestResponse.fromJson(Map<String, dynamic> json) => ScanReceiptRequestResponse(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
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
