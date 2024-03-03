// To parse this JSON data, do
//
//     final pointTrackerDetailsRequestResponse = pointTrackerDetailsRequestResponseFromJson(jsonString);

import 'dart:convert';

PointTrackerDetailsRequestResponse pointTrackerDetailsRequestResponseFromJson(String str) => PointTrackerDetailsRequestResponse.fromJson(json.decode(str));

String pointTrackerDetailsRequestResponseToJson(PointTrackerDetailsRequestResponse data) => json.encode(data.toJson());

class PointTrackerDetailsRequestResponse {
  bool? success;
  int? statusCode;
  List<Datum>? data;
  List<PointDetail>? pointDetails;
  List<BrandPoint>? brandPoints;

  PointTrackerDetailsRequestResponse({
    this.success,
    this.statusCode,
    this.data,
    this.pointDetails,
    this.brandPoints,
  });

  factory PointTrackerDetailsRequestResponse.fromJson(Map<String, dynamic> json) => PointTrackerDetailsRequestResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    pointDetails: json["point_details"] == null ? [] : List<PointDetail>.from(json["point_details"]!.map((x) => PointDetail.fromJson(x))),
    brandPoints: json["brand_points"] == null ? [] : List<BrandPoint>.from(json["brand_points"]!.map((x) => BrandPoint.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "point_details": pointDetails == null ? [] : List<dynamic>.from(pointDetails!.map((x) => x.toJson())),
    "brand_points": brandPoints == null ? [] : List<dynamic>.from(brandPoints!.map((x) => x.toJson())),
  };
}

class BrandPoint {
  String? brandName;
  String? brandNameArabic;
  int? points;

  BrandPoint({
    this.brandName,
    this.brandNameArabic,
    this.points,
  });

  factory BrandPoint.fromJson(Map<String, dynamic> json) => BrandPoint(
    brandName: json["brand_name"],
    brandNameArabic: json["brand_name_arabic"],
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "brand_name": brandName,
    "brand_name_arabic": brandNameArabic,
    "points": points,
  };
}

class Datum {
  int? id;
  int? customerId;
  int? superMarketId;
  String? supermarketName;
  int? totalPoints;
  int? letsCollectPoints;
  int? partnerPoints;
  int? brandPoints;
  String? expiryDate;
  String? addedDate;

  Datum({
    this.id,
    this.customerId,
    this.superMarketId,
    this.supermarketName,
    this.totalPoints,
    this.letsCollectPoints,
    this.partnerPoints,
    this.brandPoints,
    this.expiryDate,
    this.addedDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    customerId: json["customer_id"],
    superMarketId: json["super_market_id"],
    supermarketName: json["supermarket_name"],
    totalPoints: json["total_points"],
    letsCollectPoints: json["lets_collect_points"],
    partnerPoints: json["partner_points"],
    brandPoints: json["brand_points"],
    expiryDate: json["expiry_date"],
    addedDate: json["added_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "super_market_id": superMarketId,
    "supermarket_name": supermarketName,
    "total_points": totalPoints,
    "lets_collect_points": letsCollectPoints,
    "partner_points": partnerPoints,
    "brand_points": brandPoints,
    "expiry_date": expiryDate,
    "added_date": addedDate,
  };
}

class PointDetail {
  int? id;
  int? customerPointsTransactionId;
  int? productId;
  String? productName;
  String? productNameAr;
  int? brandId;
  String? brandName;
  String? brandNameAr;
  String? transactionOther;
  int? pointTierId;
  int? points;
  String? pointTierName;

  PointDetail({
    this.id,
    this.customerPointsTransactionId,
    this.productId,
    this.productName,
    this.productNameAr,
    this.brandId,
    this.brandName,
    this.brandNameAr,
    this.transactionOther,
    this.pointTierId,
    this.points,
    this.pointTierName,
  });

  factory PointDetail.fromJson(Map<String, dynamic> json) => PointDetail(
    id: json["id"],
    customerPointsTransactionId: json["customer_points_transaction_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    productNameAr: json["product_name_ar"],
    brandId: json["brand_id"],
    brandName: json["brand_name"],
    brandNameAr: json["brand_name_ar"],
    transactionOther: json["transaction_other"],
    pointTierId: json["point_tier_id"],
    points: json["points"],
    pointTierName: json["point_tier_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_points_transaction_id": customerPointsTransactionId,
    "product_id": productId,
    "product_name": productName,
    "product_name_ar": productNameAr,
    "brand_id": brandId,
    "brand_name": brandName,
    "brand_name_ar": brandNameAr,
    "transaction_other": transactionOther,
    "point_tier_id": pointTierId,
    "points": points,
    "point_tier_name": pointTierName,
  };
}
