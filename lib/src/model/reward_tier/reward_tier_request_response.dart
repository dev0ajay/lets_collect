// To parse this JSON data, do
//
//     final rewardTierRequestResponse = rewardTierRequestResponseFromJson(jsonString);

import 'dart:convert';

RewardTierRequestResponse rewardTierRequestResponseFromJson(String str) => RewardTierRequestResponse.fromJson(json.decode(str));

String rewardTierRequestResponseToJson(RewardTierRequestResponse data) => json.encode(data.toJson());

class RewardTierRequestResponse {
  final bool? success;
  final int? statusCode;
  final List<Datum>? data;
  final int? totalPoints;

  RewardTierRequestResponse({
    this.success,
    this.statusCode,
    this.data,
    this.totalPoints,
  });

  factory RewardTierRequestResponse.fromJson(Map<String, dynamic> json) => RewardTierRequestResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    totalPoints: json["total_points"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "total_points": totalPoints,
  };
}

class Datum {
  final int? brandId;
  final String? brandName;
  final String? brandNameArabic;
  final String? brandLogo;
  final int? requiredPoints;

  Datum({
    this.brandId,
    this.brandName,
    this.brandNameArabic,
    this.brandLogo,
    this.requiredPoints,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    brandId: json["brand_id"],
    brandName: json["brand_name"],
    brandNameArabic: json["brand_name_arabic"],
    brandLogo: json["brand_logo"],
    requiredPoints: json["required_points"],
  );

  Map<String, dynamic> toJson() => {
    "brand_id": brandId,
    "brand_name": brandName,
    "brand_name_arabic": brandNameArabic,
    "brand_logo": brandLogo,
    "required_points": requiredPoints,
  };
}
