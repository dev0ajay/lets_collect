
import 'dart:convert';

BrandAndPartnerProductRequest brandAndPartnerProductRequestFromJson(String str) => BrandAndPartnerProductRequest.fromJson(json.decode(str));

String brandAndPartnerProductRequestToJson(BrandAndPartnerProductRequest data) => json.encode(data.toJson());

class BrandAndPartnerProductRequest {
  final String sort;
  final String eligible;
  final String brandId;
  // final String redemptionTier;

  BrandAndPartnerProductRequest({
    required this.sort,
    required this.eligible,
    required this.brandId,
    // required this.redemptionTier,
  });

  factory BrandAndPartnerProductRequest.fromJson(Map<String, dynamic> json) => BrandAndPartnerProductRequest(
    sort: json["sort"],
    eligible: json["eligible"],
    brandId: json["brand_id"],
    // redemptionTier: json["redemption_tier"],
  );

  Map<String, dynamic> toJson() => {
    "sort": sort,
    "eligible": eligible,
    "brand_id": brandId,
    // "redemption_tier": redemptionTier,
  };
}
