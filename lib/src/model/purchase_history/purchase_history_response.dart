
import 'dart:convert';

PurchaseHistoryResponse purchaseHistoryResponseFromJson(String str) => PurchaseHistoryResponse.fromJson(json.decode(str));

String purchaseHistoryResponseToJson(PurchaseHistoryResponse data) => json.encode(data.toJson());

class PurchaseHistoryResponse {
  bool? success;
  int? statusCode;
  List<Datum>? data;
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
  int? receiptId;
  int? customerId;
  int? supermarketId;
  String? branch;
  DateTime? receiptDate;
  String? totalAmount;
  String? currencyCode;
  String? receiptNumber;
  int? totalNoOfProducts;
  int? totalTaxAmount;
  String? servedBy;
  String? tillNumber;
  String? paymentMethod;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    receiptId: json["receipt_id"],
    customerId: json["customer_id"],
    supermarketId: json["supermarket_id"],
    branch: json["branch"],
    receiptDate: json["receipt_date"] == null ? null : DateTime.parse(json["receipt_date"]),
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
    "receipt_date": "${receiptDate!.year.toString().padLeft(4, '0')}-${receiptDate!.month.toString().padLeft(2, '0')}-${receiptDate!.day.toString().padLeft(2, '0')}",
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
