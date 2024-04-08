
import 'dart:convert';

ReferralListResponse referralListResponseFromJson(String str) => ReferralListResponse.fromJson(json.decode(str));

String referralListResponseToJson(ReferralListResponse data) => json.encode(data.toJson());

class ReferralListResponse {
  final bool success;
  final int statusCode;
  final List<Datum> data;
  final CmsData cmsData;

  ReferralListResponse({
    required this.success,
    required this.statusCode,
    required this.data,
    required this.cmsData,
  });

  factory ReferralListResponse.fromJson(Map<String, dynamic> json) => ReferralListResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    cmsData: CmsData.fromJson(json["cms_data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "cms_data": cmsData.toJson(),
  };
}

class CmsData {
  final String pageTitle;
  final String pageTitleArabic;
  final String pageContent;
  final String pageContentArabic;
  final int status;

  CmsData({
    required this.pageTitle,
    required this.pageTitleArabic,
    required this.pageContent,
    required this.pageContentArabic,
    required this.status,
  });

  factory CmsData.fromJson(Map<String, dynamic> json) => CmsData(
    pageTitle: json["page_title"],
    pageTitleArabic: json["page_title_arabic"],
    pageContent: json["page_content"],
    pageContentArabic: json["page_content_arabic"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "page_title": pageTitle,
    "page_title_arabic": pageTitleArabic,
    "page_content": pageContent,
    "page_content_arabic": pageContentArabic,
    "status": status,
  };
}

class Datum {
  final int referralId;
  final String startDate;
  final String expiryDate;
  final String refererTier;
  final int refererPoints;
  final String referralToTier;
  final int referralToPoints;

  Datum({
    required this.referralId,
    required this.startDate,
    required this.expiryDate,
    required this.refererTier,
    required this.refererPoints,
    required this.referralToTier,
    required this.referralToPoints,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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