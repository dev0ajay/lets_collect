
import 'dart:convert';

BrandAndPartnerProductRequestResponse brandAndPartnerProductRequestResponseFromJson(String str) => BrandAndPartnerProductRequestResponse.fromJson(json.decode(str));

String brandAndPartnerProductRequestResponseToJson(BrandAndPartnerProductRequestResponse data) => json.encode(data.toJson());

class BrandAndPartnerProductRequestResponse {
  bool? success;
  int? statusCode;
  Data? data;
  String? message;

  BrandAndPartnerProductRequestResponse({
    this.success,
    this.statusCode,
    this.data,
    this.message,
  });

  factory BrandAndPartnerProductRequestResponse.fromJson(Map<String, dynamic> json) => BrandAndPartnerProductRequestResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<Reward>? rewards;

  Data({
    this.rewards,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    rewards: json["rewards"] == null ? [] : List<Reward>.from(json["rewards"]!.map((x) => Reward.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "rewards": rewards == null ? [] : List<dynamic>.from(rewards!.map((x) => x.toJson())),
  };
}

class Reward {
  int? rewardId;
  int? brandId;
  String? rewardType;
  int? productId;
  String? cashbackAmount;
  int? requiredPoints;
  int? redemptionTier;
  DateTime? expiryDate;
  List<String>? reedemStores;
  String? rewardImage;
  int? status;
  DateTime? addedDate;
  String? brandName;
  String? brandNameArabic;
  String? brandLogo;
  String? productName;
  String? productNameArabic;
  String? productImage;
  String? partnerName;
  String? partnerLogo;
  int? brandPoints;

  Reward({
    this.rewardId,
    this.brandId,
    this.rewardType,
    this.productId,
    this.cashbackAmount,
    this.requiredPoints,
    this.redemptionTier,
    this.expiryDate,
    this.reedemStores,
    this.rewardImage,
    this.status,
    this.addedDate,
    this.brandName,
    this.brandNameArabic,
    this.brandLogo,
    this.productName,
    this.productNameArabic,
    this.productImage,
    this.partnerName,
    this.partnerLogo,
    this.brandPoints,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
    rewardId: json["reward_id"],
    brandId: json["brand_id"],
    rewardType: json["reward_type"],
    productId: json["product_id"],
    cashbackAmount: json["cashback_amount"],
    requiredPoints: json["required_points"],
    redemptionTier: json["redemption_tier"],
    expiryDate: json["expiry_date"] == null ? null : DateTime.parse(json["expiry_date"]),
    reedemStores: json["reedem_stores"] == null ? [] : List<String>.from(json["reedem_stores"]!.map((x) => x)),
    rewardImage: json["reward_image"],
    status: json["status"],
    addedDate: json["added_date"] == null ? null : DateTime.parse(json["added_date"]),
    brandName: json["brand_name"],
    brandNameArabic: json["brand_name_arabic"],
    brandLogo: json["brand_logo"],
    productName: json["product_name"],
    productNameArabic: json["product_name_arabic"],
    productImage: json["product_image"],
    partnerName: json["partner_name"],
    partnerLogo: json["partner_logo"],
    brandPoints: json["brand_points"],
  );

  Map<String, dynamic> toJson() => {
    "reward_id": rewardId,
    "brand_id": brandId,
    "reward_type": rewardType,
    "product_id": productId,
    "cashback_amount": cashbackAmount,
    "required_points": requiredPoints,
    "redemption_tier": redemptionTier,
    "expiry_date": "${expiryDate!.year.toString().padLeft(4, '0')}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}",
    "reedem_stores": reedemStores == null ? [] : List<dynamic>.from(reedemStores!.map((x) => x)),
    "reward_image": rewardImage,
    "status": status,
    "added_date": addedDate?.toIso8601String(),
    "brand_name": brandName,
    "brand_name_arabic": brandNameArabic,
    "brand_logo": brandLogo,
    "product_name": productName,
    "product_name_arabic": productNameArabic,
    "product_image": productImage,
    "partner_name": partnerName,
    "partner_logo": partnerLogo,
    "brand_points": brandPoints,
  };
}
