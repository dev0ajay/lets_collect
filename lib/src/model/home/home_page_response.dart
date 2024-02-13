

import 'dart:convert';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  bool? success;
  int? statusCode;
  Data? data;
  int? totalPoints;
  int? emailVerified;
  int? emailVerificationPoints;

  HomeResponse({
    this.success,
    this.statusCode,
    this.data,
    this.totalPoints,
    this.emailVerified,
    this.emailVerificationPoints,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    totalPoints: json["total_points"],
    emailVerified: json["email_verified"],
    emailVerificationPoints: json["email_verification_points"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data?.toJson(),
    "total_points": totalPoints,
    "email_verified": emailVerified,
    "email_verification_points": emailVerificationPoints,
  };
}

class Data {
  List<Brand>? brands;
  List<Offer>? offers;

  Data({
    this.brands,
    this.offers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    brands: json["brands"] == null ? [] : List<Brand>.from(json["brands"]!.map((x) => Brand.fromJson(x))),
    offers: json["offers"] == null ? [] : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x.toJson())),
    "offers": offers == null ? [] : List<dynamic>.from(offers!.map((x) => x.toJson())),
  };
}

class Brand {
  int? id;
  String? brandName;
  String? brandNameArabic;
  String? brandLogo;
  String? brandLink;
  int? defaultPoints;
  int? status;

  Brand({
    this.id,
    this.brandName,
    this.brandNameArabic,
    this.brandLogo,
    this.brandLink,
    this.defaultPoints,
    this.status,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    brandName: json["brand_name"],
    brandNameArabic: json["brand_name_arabic"],
    brandLogo: json["brand_logo"],
    brandLink: json["brand_link"],
    defaultPoints: json["default_points"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand_name": brandName,
    "brand_name_arabic": brandNameArabic,
    "brand_logo": brandLogo,
    "brand_link": brandLink,
    "default_points": defaultPoints,
    "status": status,
  };
}

class Offer {
  int? id;
  String? offerHeading;
  String? offerHeadingArabic;
  String? offerDetails;
  String? offerDetailsArabic;
  String? productQtyLimit;
  String? superMartkets;
  dynamic scanNumLimit;
  int? offerRuleValue;
  String? offerImage;
  String? startDate;
  String? endDate;
  int? associatedPoints;
  int? pointsTierId;
  int? pointValidityPeriod;
  int? moicApproval;
  List<String>? superMartketName;

  Offer({
    this.id,
    this.offerHeading,
    this.offerHeadingArabic,
    this.offerDetails,
    this.offerDetailsArabic,
    this.productQtyLimit,
    this.superMartkets,
    this.scanNumLimit,
    this.offerRuleValue,
    this.offerImage,
    this.startDate,
    this.endDate,
    this.associatedPoints,
    this.pointsTierId,
    this.pointValidityPeriod,
    this.moicApproval,
    this.superMartketName,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    offerHeading: json["offer_heading"],
    offerHeadingArabic: json["offer_heading_arabic"],
    offerDetails: json["offer_details"],
    offerDetailsArabic: json["offer_details_arabic"],
    productQtyLimit: json["product_qty_limit"],
    superMartkets: json["super_martkets"],
    scanNumLimit: json["scan_num_limit"],
    offerRuleValue: json["offer_rule_value"],
    offerImage: json["offer_image"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    associatedPoints: json["associated_points"],
    pointsTierId: json["points_tier_id"],
    pointValidityPeriod: json["point_validity_period"],
    moicApproval: json["moic_approval"],
    superMartketName: json["super_martket_name"] == null ? [] : List<String>.from(json["super_martket_name"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "offer_heading": offerHeading,
    "offer_heading_arabic": offerHeadingArabic,
    "offer_details": offerDetails,
    "offer_details_arabic": offerDetailsArabic,
    "product_qty_limit": productQtyLimit,
    "super_martkets": superMartkets,
    "scan_num_limit": scanNumLimit,
    "offer_rule_value": offerRuleValue,
    "offer_image": offerImage,
    "start_date": startDate,
    "end_date": endDate,
    "associated_points": associatedPoints,
    "points_tier_id": pointsTierId,
    "point_validity_period": pointValidityPeriod,
    "moic_approval": moicApproval,
    "super_martket_name": superMartketName == null ? [] : List<dynamic>.from(superMartketName!.map((x) => x)),
  };
}
