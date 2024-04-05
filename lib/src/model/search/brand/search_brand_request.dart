// To parse this JSON data, do
//
//     final searchBrandRequest = searchBrandRequestFromJson(jsonString);

import 'dart:convert';

SearchBrandRequest searchBrandRequestFromJson(String str) => SearchBrandRequest.fromJson(json.decode(str));

String searchBrandRequestToJson(SearchBrandRequest data) => json.encode(data.toJson());

class SearchBrandRequest {
  final String departmentId;
  final String searchText;
  final String page;

  SearchBrandRequest({
    required this.departmentId,
    required this.searchText,
    required this.page,
  });

  factory SearchBrandRequest.fromJson(Map<String, dynamic> json) => SearchBrandRequest(
    departmentId: json["department_id"],
    searchText: json["search_text"],
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "department_id": departmentId,
    "search_text": searchText,
    "page": page,
  };
}
