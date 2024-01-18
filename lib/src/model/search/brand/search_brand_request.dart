import 'dart:convert';

SearchBrandRequest searchBrandRequestFromJson(String str) => SearchBrandRequest.fromJson(json.decode(str));

String searchBrandRequestToJson(SearchBrandRequest data) => json.encode(data.toJson());

class SearchBrandRequest {
  final String categoryId;
  final String searchText;
  final String page;

  SearchBrandRequest({
    required this.categoryId,
    required this.searchText,
    required this.page,
  });

  factory SearchBrandRequest.fromJson(Map<String, dynamic> json) => SearchBrandRequest(
    categoryId: json["category_id"],
    searchText: json["search_text"],
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "search_text": searchText,
    "page": page,
  };
}
