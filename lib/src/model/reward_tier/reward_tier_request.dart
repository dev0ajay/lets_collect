
import 'dart:convert';

RewardTierRequest rewardTierRequestFromJson(String str) => RewardTierRequest.fromJson(json.decode(str));

String rewardTierRequestToJson(RewardTierRequest data) => json.encode(data.toJson());

class RewardTierRequest {
  final String sort;
  // final String eligible;
  // final String categoryId;
  // final String brandId;

  RewardTierRequest({
    required this.sort,
    // required this.eligible,
    // required this.categoryId,
    // required this.brandId,
  });

  factory RewardTierRequest.fromJson(Map<String, dynamic> json) => RewardTierRequest(
    sort: json["sort"],
    // eligible: json["eligible"],
    // categoryId: json["category_id"],
    // brandId: json["brand_id"],
  );

  Map<String, dynamic> toJson() => {
    "sort": sort,
    // "eligible": eligible,
    // "category_id": categoryId,
    // "brand_id": brandId,
  };
}
