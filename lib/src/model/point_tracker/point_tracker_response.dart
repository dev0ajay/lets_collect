import 'dart:convert';

PointTrackerRequestResponse pointTrackerRequestResponseFromJson(String str) =>
    PointTrackerRequestResponse.fromJson(json.decode(str));

String pointTrackerRequestResponseToJson(PointTrackerRequestResponse data) =>
    json.encode(data.toJson());

class PointTrackerRequestResponse {
  bool success;
  int statusCode;
  List<PointTrackerData> data;
  List<BrandPoint> brandPoints;
  int totalPoints;
  int totalPages;

  PointTrackerRequestResponse({
    required this.success,
    required this.statusCode,
    required this.data,
    required this.brandPoints,
    required this.totalPoints,
    required this.totalPages,
  });

  factory PointTrackerRequestResponse.fromJson(Map<String, dynamic> json) {
    return PointTrackerRequestResponse(
      success: json["success"] ?? false,
      statusCode: json["status_code"] ?? 0,
      data: (json["data"] != null && json["data"] is List)
          ? List<PointTrackerData>.from(json["data"].map((x) => PointTrackerData.fromJson(x)))
          : [],
      brandPoints: (json["brand_points"] != null &&
          json["brand_points"] is List)
          ? List<BrandPoint>.from(
          json["brand_points"].map((x) => BrandPoint.fromJson(x)))
          : [],
      totalPoints: json["total_points"] ?? 0,
      totalPages: json["total_pages"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "brand_points": List<dynamic>.from(brandPoints.map((x) => x.toJson())),
    "total_points": totalPoints,
    "total_pages": totalPages,
  };
}

class BrandPoint {
  String brandName;
  String brandNameArabic;
  dynamic points;

  BrandPoint({
    required this.brandName,
    required this.brandNameArabic,
    required this.points,
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

class PointTrackerData {
  int id;
  int customerId;
  int superMarketId;
  String supermarketName;
  int totalPoints;
  int letsCollectPoints;
  int partnerPoints;
  int brandPoints;
  String expiryDate;
  String addedDate;

  PointTrackerData({
    required this.id,
    required this.customerId,
    required this.superMarketId,
    required this.supermarketName,
    required this.totalPoints,
    required this.letsCollectPoints,
    required this.partnerPoints,
    required this.brandPoints,
    required this.expiryDate,
    required this.addedDate,
  });

  factory PointTrackerData.fromJson(Map<String, dynamic> json) => PointTrackerData(
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
