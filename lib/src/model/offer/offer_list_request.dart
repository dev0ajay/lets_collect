
import 'dart:convert';

OfferListRequest offerListRequestFromJson(String str) => OfferListRequest.fromJson(json.decode(str));

String offerListRequestToJson(OfferListRequest data) => json.encode(data.toJson());

class OfferListRequest {
  final String sort;
  final String brandId;
  final String categoryId;

  OfferListRequest({
    required this.sort,
    required this.brandId,
    required this.categoryId,
  });

  factory OfferListRequest.fromJson(Map<String, dynamic> json) => OfferListRequest(
    sort: json["sort"],
    brandId: json["brand_id"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "sort": sort,
    "brand_id": brandId,
    "category_id": categoryId,
  };
}
