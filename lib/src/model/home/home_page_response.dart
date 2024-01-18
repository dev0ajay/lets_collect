
import 'dart:convert';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  final bool success;
  final int statusCode;
  final Data data;
  final int totalPoints;
  final int emailVerified;
  final int emailVerificationPoints;

  HomeResponse({
    required this.success,
    required this.statusCode,
    required this.data,
    required this.totalPoints,
    required this.emailVerified,
    required this.emailVerificationPoints,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: Data.fromJson(json["data"]),
    totalPoints: json["total_points"],
    emailVerified: json["email_verified"],
    emailVerificationPoints: json["email_verification_points"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data.toJson(),
    "total_points": totalPoints,
    "email_verified": emailVerified,
    "email_verification_points": emailVerificationPoints,
  };
}

class Data {
  final List<Brand> brands;
  final List<Offer> offers;

  Data({
    required this.brands,
    required this.offers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "brands": List<dynamic>.from(brands.map((x) => x.toJson())),
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
  };
}

class Brand {
  final int id;
  final String brandName;
  final String brandNameArabic;
  final String brandLogo;
  final String brandLink;
  final int defaultPoints;
  final int status;

  Brand({
    required this.id,
    required this.brandName,
    required this.brandNameArabic,
    required this.brandLogo,
    required this.brandLink,
    required this.defaultPoints,
    required this.status,
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
  final int id;
  final String offerHeading;
  final String offerHeadingArabic;
  final String offerDetails;
  final String offerDetailsArabic;
  final String ageGroup;
  final String productQtyLimit;
  final String superMartkets;
  final dynamic scanNumLimit;
  final int offerRuleValue;
  final String offerImage;
  final String startDate;
  final String endDate;
  final int associatedPoints;
  final int pointsTierId;
  final int pointValidityPeriod;
  final int moicApproval;

  Offer({
    required this.id,
    required this.offerHeading,
    required this.offerHeadingArabic,
    required this.offerDetails,
    required this.offerDetailsArabic,
    required this.ageGroup,
    required this.productQtyLimit,
    required this.superMartkets,
    required this.scanNumLimit,
    required this.offerRuleValue,
    required this.offerImage,
    required this.startDate,
    required this.endDate,
    required this.associatedPoints,
    required this.pointsTierId,
    required this.pointValidityPeriod,
    required this.moicApproval,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    offerHeading: json["offer_heading"],
    offerHeadingArabic: json["offer_heading_arabic"],
    offerDetails: json["offer_details"],
    offerDetailsArabic: json["offer_details_arabic"],
    ageGroup: json["age_group"],
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "offer_heading": offerHeading,
    "offer_heading_arabic": offerHeadingArabic,
    "offer_details": offerDetails,
    "offer_details_arabic": offerDetailsArabic,
    "age_group": ageGroup,
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
  };
}
