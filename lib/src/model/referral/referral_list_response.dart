import 'dart:convert';

ReferralListResponse referralListResponseFromJson(String str) => ReferralListResponse.fromJson(json.decode(str));

String referralListResponseToJson(ReferralListResponse data) => json.encode(data.toJson());

class ReferralListResponse {
  bool success;
  int statusCode;
  List<ReferralList> data;

  ReferralListResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory ReferralListResponse.fromJson(Map<String, dynamic> json) => ReferralListResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: List<ReferralList>.from(json["data"].map((x) => ReferralList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ReferralList {
  int referralId;
  String startDate;
  String expiryDate;
  String refererTier;
  int refererPoints;
  String referralToTier;
  int referralToPoints;

  ReferralList({
    required this.referralId,
    required this.startDate,
    required this.expiryDate,
    required this.refererTier,
    required this.refererPoints,
    required this.referralToTier,
    required this.referralToPoints,
  });

  factory ReferralList.fromJson(Map<String, dynamic> json) => ReferralList(
    referralId: json["referral_id"],
    startDate: json["start_date"],
    expiryDate: json["expiry_date"],
    refererTier: json["referer_tier"],
    refererPoints: json["referer_points"],
    referralToTier: json["referral_to_tier"],
    referralToPoints: json["referral_to_points"],
  );

  Map<String, dynamic> toJson() => {
    "referral_id": referralId,
    "start_date": startDate,
    "expiry_date": expiryDate,
    "referer_tier": refererTier,
    "referer_points": refererPoints,
    "referral_to_tier": referralToTier,
    "referral_to_points": referralToPoints,
  };
}
