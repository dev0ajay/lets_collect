

import 'dart:convert';

PurchaseHistoryResponse purchaseHistoryResponseFromJson(String str) => PurchaseHistoryResponse.fromJson(json.decode(str));

String purchaseHistoryResponseToJson(PurchaseHistoryResponse data) => json.encode(data.toJson());

class PurchaseHistoryResponse {
  bool? success;
  int? statusCode;
  List<PurchaseData>? data;
  int? totalPages;

  PurchaseHistoryResponse({
    this.success,
    this.statusCode,
    this.data,
    this.totalPages,
  });

  factory PurchaseHistoryResponse.fromJson(Map<String, dynamic> json) => PurchaseHistoryResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? [] : List<PurchaseData>.from(json["data"]!.map((x) => PurchaseData.fromJson(x))),
    totalPages: json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "total_pages": totalPages,
  };
}

class PurchaseData {
  int? receiptId;
  int? customerId;
  int? supermarketId;
  String? branch;
  String? receiptDate;
  String? totalAmount;
  String? currencyCode;
  String? receiptNumber;
  int? totalNoOfProducts;
  String? totalTaxAmount;
  String? servedBy;
  String? tillNumber;
  String? paymentMethod;

  PurchaseData({
    this.receiptId,
    this.customerId,
    this.supermarketId,
    this.branch,
    this.receiptDate,
    this.totalAmount,
    this.currencyCode,
    this.receiptNumber,
    this.totalNoOfProducts,
    this.totalTaxAmount,
    this.servedBy,
    this.tillNumber,
    this.paymentMethod,
  });

  factory PurchaseData.fromJson(Map<String, dynamic> json) => PurchaseData(
    receiptId: json["receipt_id"],
    customerId: json["customer_id"],
    supermarketId: json["supermarket_id"],
    branch: json["branch"],
    receiptDate: json["receipt_date"] == null ? null : json["receipt_date"],
    totalAmount: json["total_amount"],
    currencyCode: json["currency_code"],
    receiptNumber: json["receipt_number"],
    totalNoOfProducts: json["total_no_of_products"],
    totalTaxAmount: json["total_tax_amount"],
    servedBy: json["served_by"],
    tillNumber: json["till_number"],
    paymentMethod: json["payment_method"],
  );

  Map<String, dynamic> toJson() => {
    "receipt_id": receiptId,
    "customer_id": customerId,
    "supermarket_id": supermarketId,
    "branch": branch,
    "receipt_date": receiptDate,
    "total_amount": totalAmount,
    "currency_code": currencyCode,
    "receipt_number": receiptNumber,
    "total_no_of_products": totalNoOfProducts,
    "total_tax_amount": totalTaxAmount,
    "served_by": servedBy,
    "till_number": tillNumber,
    "payment_method": paymentMethod,
  };
}
