
import 'dart:convert';

SearchCategoryRequest searchCategoryRequestFromJson(String str) => SearchCategoryRequest.fromJson(json.decode(str));

String searchCategoryRequestToJson(SearchCategoryRequest data) => json.encode(data.toJson());

class SearchCategoryRequest {
  final String searchText;

  SearchCategoryRequest({
    required this.searchText,
  });

  factory SearchCategoryRequest.fromJson(Map<String, dynamic> json) => SearchCategoryRequest(
    searchText: json["search_text"],
  );

  Map<String, dynamic> toJson() => {
    "search_text": searchText,
  };
}
