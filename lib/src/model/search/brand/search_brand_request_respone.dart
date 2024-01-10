import 'dart:convert';

SearchBrandRequestResponse searchBrandRequestResponeFromJson(String str) => SearchBrandRequestResponse.fromJson(json.decode(str));

String searchBrandRequestResponeToJson(SearchBrandRequestResponse data) => json.encode(data.toJson());

class SearchBrandRequestResponse {
  final bool success;
  final int statusCode;
  final List<BrandItem> data;
  final int totalPages;

  SearchBrandRequestResponse({
    required this.success,
    required this.statusCode,
    required this.data,
    required this.totalPages,
  });

  factory SearchBrandRequestResponse.fromJson(Map<String, dynamic> json) => SearchBrandRequestResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: List<BrandItem>.from(json["data"].map((x) => BrandItem.fromJson(x))),
    totalPages: json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total_pages": totalPages,
  };
}

class BrandItem {
  final int id;
  final String brandName;
  final String brandNameArabic;
  final String brandLogo;
  final String brandLink;
  final int defaultPoints;
  final int status;

  BrandItem({
    required this.id,
    required this.brandName,
    required this.brandNameArabic,
    required this.brandLogo,
    required this.brandLink,
    required this.defaultPoints,
    required this.status,
  });

  factory BrandItem.fromJson(Map<String, dynamic> json) => BrandItem(
    id: json["id"],
    brandName: json["brand_name"],
    brandNameArabic: json["brand_name_arabic"],
    brandLogo: json["brand_logo"],
    brandLink: json["brand_link"],
    defaultPoints: json["default_points"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand_name": brandName,
    "brand_name_arabic": brandNameArabic,
    "brand_logo": brandLogo,
    "brand_link": brandLink,
    "default_points": defaultPoints,
    "status": status,
  };
}
