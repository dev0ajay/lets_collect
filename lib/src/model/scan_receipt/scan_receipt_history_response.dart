

import 'dart:convert';

ScanReceiptHistoryResponse scanReceiptHistoryResponseFromJson(String str) => ScanReceiptHistoryResponse.fromJson(json.decode(str));

String scanReceiptHistoryResponseToJson(ScanReceiptHistoryResponse data) => json.encode(data.toJson());

class ScanReceiptHistoryResponse {
  final bool? success;
  final List<Datum>? data;
  final String? message;

  ScanReceiptHistoryResponse({
    this.success,
    this.data,
    this.message,
  });

  factory ScanReceiptHistoryResponse.fromJson(Map<String, dynamic> json) => ScanReceiptHistoryResponse(
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  final String? productName;
  final String? brandName;
  final int? points;
  final DateTime? addedDate;

  Datum({
    this.productName,
    this.brandName,
    this.points,
    this.addedDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    productName: json["product_name"],
    brandName: json["brand_name"],
    points: json["points"],
    addedDate: json["added_date"] == null ? null : DateTime.parse(json["added_date"]),
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "brand_name": brandName,
    "points": points,
    "added_date": addedDate?.toIso8601String(),
  };
}
