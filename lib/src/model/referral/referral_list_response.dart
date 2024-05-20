import 'dart:convert';

class ReferralListResponse {
  bool? success;
  int? statusCode;
  List<dynamic>? data;
  CmsData? cmsData;

  ReferralListResponse({
    this.success,
    this.statusCode,
    this.data,
    this.cmsData,
  });

  factory ReferralListResponse.fromRawJson(String str) => ReferralListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReferralListResponse.fromJson(Map<String, dynamic> json) => ReferralListResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    cmsData: json["cms_data"] == null ? null : CmsData.fromJson(json["cms_data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    "cms_data": cmsData?.toJson(),
  };
}

class CmsData {
  String? pageTitle;
  String? pageTitleArabic;
  String? pageContent;
  String? pageContentArabic;
  int? status;

  CmsData({
    this.pageTitle,
    this.pageTitleArabic,
    this.pageContent,
    this.pageContentArabic,
    this.status,
  });

  factory CmsData.fromRawJson(String str) => CmsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
