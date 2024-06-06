// To parse this JSON data, do
//
//     final brandAndCategoryFilterResponse = brandAndCategoryFilterResponseFromJson(jsonString);

import 'dart:convert';

BrandAndCategoryFilterResponse brandAndCategoryFilterResponseFromJson(String str) => BrandAndCategoryFilterResponse.fromJson(json.decode(str));

String brandAndCategoryFilterResponseToJson(BrandAndCategoryFilterResponse data) => json.encode(data.toJson());

class BrandAndCategoryFilterResponse {
  final bool? success;
  final int? statusCode;
  final Data? data;

  BrandAndCategoryFilterResponse({
    this.success,
    this.statusCode,
    this.data,
  });

  factory BrandAndCategoryFilterResponse.fromJson(Map<String, dynamic> json) => BrandAndCategoryFilterResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data?.toJson(),
  };
}

class Data {
  final List<Brand>? brands;
  final List<Category>? category;

  Data({
    this.brands,
    this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    brands: json["brands"] == null ? [] : List<Brand>.from(json["brands"]!.map((x) => Brand.fromJson(x))),
    category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x.toJson())),
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
  };
}

class Brand {
  final int? id;
  final String? brandName;
  final String? brandNameArabic;
  final String? brandLink;
  final int? defaultPoints;
  final int? status;

  Brand({
    this.id,
    this.brandName,
    this.brandNameArabic,
    this.brandLink,
    this.defaultPoints,
    this.status,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    brandName: json["brand_name"],
    brandNameArabic: json["brand_name_arabic"],
    brandLink: json["brand_link"],
    defaultPoints: json["default_points"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand_name": brandName,
    "brand_name_arabic": brandNameArabic,
    "brand_link": brandLink,
    "default_points": defaultPoints,
    "status": status,
  };
}

class Category {
  final int? id;
  final String? category;
  final String? categoryNameArabic;

  Category({
    this.id,
    this.category,
    this.categoryNameArabic,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    category: json["category"],
    categoryNameArabic: json["category_name_arabic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "category_name_arabic": categoryNameArabic,
  };
}
