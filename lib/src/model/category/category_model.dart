import 'dart:convert';

CategoryFilterResponse categoryFilterResponseFromJson(String str) => CategoryFilterResponse.fromJson(json.decode(str));

String categoryFilterResponseToJson(CategoryFilterResponse data) => json.encode(data.toJson());

class CategoryFilterResponse {
  final bool success;
  final int statusCode;
  final List<Category> data;

  CategoryFilterResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory CategoryFilterResponse.fromJson(Map<String, dynamic> json) => CategoryFilterResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Category {
  final int id;
  final String category;
  final String categoryNameArabic;

  Category({
    required this.id,
    required this.category,
    required this.categoryNameArabic,
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
