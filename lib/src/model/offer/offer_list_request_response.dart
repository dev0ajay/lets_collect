
import 'dart:convert';

OfferListRequestResponse offerListRequestResponseFromJson(String str) => OfferListRequestResponse.fromJson(json.decode(str));

String offerListRequestResponseToJson(OfferListRequestResponse data) => json.encode(data.toJson());

class OfferListRequestResponse {
  bool? success;
  int? statusCode;
  List<Datum>? data;

  OfferListRequestResponse({
    this.success,
    this.statusCode,
    this.data,
  });

  factory OfferListRequestResponse.fromJson(Map<String, dynamic> json) => OfferListRequestResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? offerHeading;
  String? offerHeadingArabic;
  String? offerDetails;
  String? offerDetailsArabic;
  String? productQtyLimit;
  String? superMartkets;
  int? offerRuleValue;
  String? offerImage;
  String? startDate;
  String? endDate;
  int? associatedPoints;
  int? pointsTierId;
  int? pointValidityPeriod;
  List<String>? superMartketName;

  Datum({
    this.id,
    this.offerHeading,
    this.offerHeadingArabic,
    this.offerDetails,
    this.offerDetailsArabic,
    this.productQtyLimit,
    this.superMartkets,
    this.offerRuleValue,
    this.offerImage,
    this.startDate,
    this.endDate,
    this.associatedPoints,
    this.pointsTierId,
    this.pointValidityPeriod,
    this.superMartketName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    offerHeading: json["offer_heading"],
    offerHeadingArabic: json["offer_heading_arabic"],
    offerDetails: json["offer_details"],
    offerDetailsArabic: json["offer_details_arabic"],
    productQtyLimit: json["product_qty_limit"],
    superMartkets: json["super_martkets"],
    offerRuleValue: json["offer_rule_value"],
    offerImage: json["offer_image"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    associatedPoints: json["associated_points"],
    pointsTierId: json["points_tier_id"],
    pointValidityPeriod: json["point_validity_period"],
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
    "offer_rule_value": offerRuleValue,
    "offer_image": offerImage,
    "start_date": startDate,
    "end_date": endDate,
    "associated_points": associatedPoints,
    "points_tier_id": pointsTierId,
    "point_validity_period": pointValidityPeriod,
    "super_martket_name": superMartketName == null ? [] : List<dynamic>.from(superMartketName!.map((x) => x)),
  };
}
