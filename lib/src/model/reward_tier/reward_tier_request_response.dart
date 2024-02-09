
import 'dart:convert';

RewardTierRequestResponse rewardTierRequestResponseFromJson(String str) => RewardTierRequestResponse.fromJson(json.decode(str));

String rewardTierRequestResponseToJson(RewardTierRequestResponse data) => json.encode(data.toJson());

class RewardTierRequestResponse {
  final bool? success;
  final int? statusCode;
  final Data? data;
  final int? totalPoints;

  RewardTierRequestResponse({
    this.success,
    this.statusCode,
    this.data,
    this.totalPoints,
  });

  factory RewardTierRequestResponse.fromJson(Map<String, dynamic> json) => RewardTierRequestResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    totalPoints: json["total_points"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data?.toJson(),
    "total_points": totalPoints,
  };
}

class Data {
  final List<Partner>? partner;
  final List<LetsCollect>? letsCollect;
  final List<Brand>? brand;

  Data({
    this.partner,
    this.letsCollect,
    this.brand,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    partner: json["partner"] == null ? [] : List<Partner>.from(json["partner"]!.map((x) => Partner.fromJson(x))),
    letsCollect: json["lets_collect"] == null ? [] : List<LetsCollect>.from(json["lets_collect"]!.map((x) => LetsCollect.fromJson(x))),
    brand: json["brand"] == null ? [] : List<Brand>.from(json["brand"]!.map((x) => Brand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "partner": partner == null ? [] : List<dynamic>.from(partner!.map((x) => x.toJson())),
    "lets_collect": letsCollect == null ? [] : List<dynamic>.from(letsCollect!.map((x) => x.toJson())),
    "brand": brand == null ? [] : List<dynamic>.from(brand!.map((x) => x.toJson())),
  };
}

class Brand {
  final int? rewardId;
  final int? brandId;
  final String? rewardType;
  final int? productId;
  final String? cashbackAmount;
  final int? requiredPoints;
  final int? redemptionTier;
  final DateTime? expiryDate;
  final List<String>? reedemStores;
  final String? rewardImage;
  final int? status;
  final DateTime? addedDate;
  final String? brandName;
  final String? brandNameArabic;
  final String? brandLogo;
  final String? productName;
  final String? productNameArabic;
  final String? productImage;
  final String? partnerName;
  final String? partnerLogo;

  Brand({
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
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
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
  };
}

class LetsCollect {
  final int? rewardId;
  final int? brandId;
  final String? rewardType;
  final int? productId;
  final String? cashbackAmount;
  final int? requiredPoints;
  final int? redemptionTier;
  final DateTime? expiryDate;
  final List<String>? reedemStores;
  final String? rewardImage;
  final int? status;
  final DateTime? addedDate;
  final String? brandName;
  final String? brandNameArabic;
  final String? brandLogo;
  final String? productName;
  final String? productNameArabic;
  final String? productImage;
  final String? partnerName;
  final String? partnerLogo;

  LetsCollect({
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
  });

  factory LetsCollect.fromJson(Map<String, dynamic> json) => LetsCollect(
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
  };
}

class Partner {
  final int? rewardId;
  final int? brandId;
  final String? rewardType;
  final int? productId;
  final String? cashbackAmount;
  final int? requiredPoints;
  final int? redemptionTier;
  final DateTime? expiryDate;
  final List<String>? reedemStores;
  final String? rewardImage;
  final int? status;
  final DateTime? addedDate;
  final String? brandName;
  final String? brandNameArabic;
  final String? brandLogo;
  final String? productName;
  final String? productNameArabic;
  final String? productImage;
  final String? partnerName;
  final String? partnerLogo;

  Partner({
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
  });

  factory Partner.fromJson(Map<String, dynamic> json) => Partner(
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
  };
}
