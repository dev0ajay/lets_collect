// To parse this JSON data, do
//
//     final searchCategoryRequestResponse = searchCategoryRequestResponseFromJson(jsonString);

import 'dart:convert';

SearchCategoryRequestResponse searchCategoryRequestResponseFromJson(String str) => SearchCategoryRequestResponse.fromJson(json.decode(str));

String searchCategoryRequestResponseToJson(SearchCategoryRequestResponse data) => json.encode(data.toJson());

class SearchCategoryRequestResponse {
  bool? success;
  int? statusCode;
  List<Datum>? data;

  SearchCategoryRequestResponse({
    this.success,
    this.statusCode,
    this.data,
  });

  factory SearchCategoryRequestResponse.fromJson(Map<String, dynamic> json) => SearchCategoryRequestResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? departmentName;
  String? departmentNameArabic;
  String? departmentImage;

  Datum({
    this.id,
    this.departmentName,
    this.departmentNameArabic,
    this.departmentImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    departmentName: json["department_name"],
    departmentNameArabic: json["department_name_arabic"],
    departmentImage: json["department_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "department_name": departmentName,
    "department_name_arabic": departmentNameArabic,
    "department_image": departmentImage,
  };
}
