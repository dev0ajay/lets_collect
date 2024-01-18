
import 'dart:convert';

TermsAndConditionResponse termsAndConditionFromJson(String str) => TermsAndConditionResponse.fromJson(json.decode(str));

String termsAndConditionToJson(TermsAndConditionResponse data) => json.encode(data.toJson());

class TermsAndConditionResponse {
  final bool success;
  final int statusCode;
  final Data data;

  TermsAndConditionResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory TermsAndConditionResponse.fromJson(Map<String, dynamic> json) => TermsAndConditionResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data.toJson(),
  };
}

class Data {
  final int id;
  final String pageTitle;
  final String pageTitleArabic;
  final String pageContent;
  final String pageContentArabic;
  final int status;

  Data({
    required this.id,
    required this.pageTitle,
    required this.pageTitleArabic,
    required this.pageContent,
    required this.pageContentArabic,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    pageTitle: json["page_title"],
    pageTitleArabic: json["page_title_arabic"],
    pageContent: json["page_content"],
    pageContentArabic: json["page_content_arabic"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "page_title": pageTitle,
    "page_title_arabic": pageTitleArabic,
    "page_content": pageContent,
    "page_content_arabic": pageContentArabic,
    "status": status,
  };
}
