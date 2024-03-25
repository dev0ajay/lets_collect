// To parse this JSON data, do
//
//     final howToRedeemMyPointsResponse = howToRedeemMyPointsResponseFromJson(jsonString);

import 'dart:convert';

HowToRedeemMyPointsResponse howToRedeemMyPointsResponseFromJson(String str) => HowToRedeemMyPointsResponse.fromJson(json.decode(str));

String howToRedeemMyPointsResponseToJson(HowToRedeemMyPointsResponse data) => json.encode(data.toJson());

class HowToRedeemMyPointsResponse {
  bool success;
  int statusCode;
  Data data;

  HowToRedeemMyPointsResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory HowToRedeemMyPointsResponse.fromJson(Map<String, dynamic> json) => HowToRedeemMyPointsResponse(
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
  int id;
  String pageTitle;
  String pageTitleArabic;
  String pageContent;
  String pageContentArabic;
  int status;

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