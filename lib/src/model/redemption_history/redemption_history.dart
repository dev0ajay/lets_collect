// To parse this JSON data, do
//
//     final redemptionHistoryResponse = redemptionHistoryResponseFromJson(jsonString);

import 'dart:convert';

RedemptionHistoryResponse redemptionHistoryResponseFromJson(String str) => RedemptionHistoryResponse.fromJson(json.decode(str));

String redemptionHistoryResponseToJson(RedemptionHistoryResponse data) => json.encode(data.toJson());

class RedemptionHistoryResponse {
  bool? success;
  int? statusCode;
  List<Datum>? data;
  int? totalPages;

  RedemptionHistoryResponse({
    this.success,
    this.statusCode,
    this.data,
    this.totalPages,
  });

  factory RedemptionHistoryResponse.fromJson(Map<String, dynamic> json) => RedemptionHistoryResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    totalPages: json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "total_pages": totalPages,
  };
}

class Datum {
  int? id;
  int? productId;
  String? storeLocation;
  String? productCode;
  int? superMarketId;
  String? supermarketName;
  String? redeemDate;
  int? points;
  String? reedemTime;
  String? productName;
  String? productNameArabic;
  String? productImage;

  Datum({
    this.id,
    this.productId,
    this.storeLocation,
    this.productCode,
    this.superMarketId,
    this.supermarketName,
    this.redeemDate,
    this.points,
    this.reedemTime,
    this.productName,
    this.productNameArabic,
    this.productImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    productId: json["product_id"],
    storeLocation: json["store_location"],
    productCode: json["product_code"],
    superMarketId: json["super_market_id"],
    supermarketName: json["supermarket_name"],
    redeemDate: json["redeem_date"],
    points: json["points"],
    reedemTime: json["reedem_time"],
    productName: json["product_name"],
    productNameArabic: json["product_name_arabic"],
    productImage: json["product_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "store_location": storeLocation,
    "product_code": productCode,
    "super_market_id": superMarketId,
    "supermarket_name": supermarketName,
    "redeem_date": redeemDate,
    "points": points,
    "reedem_time": reedemTime,
    "product_name": productName,
    "product_name_arabic": productNameArabic,
    "product_image": productImage,
  };
}
