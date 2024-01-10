import 'dart:convert';

SearchCategoryRequestResponse searchCategoryRequestFromJson(String str) => SearchCategoryRequestResponse.fromJson(json.decode(str));

String searchCategoryRequestToJson(SearchCategoryRequestResponse data) => json.encode(data.toJson());

class SearchCategoryRequestResponse {
  final bool success;
  final int statusCode;
  final List<CategoryItem> data;

  SearchCategoryRequestResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory SearchCategoryRequestResponse.fromJson(Map<String, dynamic> json) => SearchCategoryRequestResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: List<CategoryItem>.from(json["data"].map((x) => CategoryItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoryItem {
  final int id;
  final String category;
  final String categoryNameArabic;
  final String categoryImage;

  CategoryItem({
    required this.id,
    required this.category,
    required this.categoryNameArabic,
    required this.categoryImage,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
    id: json["id"],
    category: json["category"],
    categoryNameArabic: json["category_name_arabic"],
    categoryImage: json["category_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "category_name_arabic": categoryNameArabic,
    "category_image": categoryImage,
  };
}
