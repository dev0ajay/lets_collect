// /// New
//
//
// // To parse this JSON data, do
// //
// //     final purchaseHistoryResponse = purchaseHistoryResponseFromJson(jsonString);
//
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// PurchaseHistoryResponse purchaseHistoryResponseFromJson(String str) => PurchaseHistoryResponse.fromJson(json.decode(str));
//
// String purchaseHistoryResponseToJson(PurchaseHistoryResponse data) => json.encode(data.toJson());
//
// class PurchaseHistoryResponse {
//   bool success;
//   int statusCode;
//   List<PurchaseData> data;
//   int totalPages;
//
//   PurchaseHistoryResponse({
//     required this.success,
//     required this.statusCode,
//     required this.data,
//     required this.totalPages,
//   });
//
//   factory PurchaseHistoryResponse.fromJson(Map<String, dynamic> json) => PurchaseHistoryResponse(
//     success: json["success"],
//     statusCode: json["status_code"],
//     data: List<PurchaseData>.from(json["data"].map((x) => PurchaseData.fromJson(x))),
//     totalPages: json["total_pages"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "status_code": statusCode,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "total_pages": totalPages,
//   };
// }
//
// class PurchaseData {
//   int receiptId;
//   int customerId;
//   int supermarketId;
//   String branch;
//   String receiptDate;
//   String totalAmount;
//   String currencyCode;
//   String receiptNumber;
//   int totalNoOfProducts;
//   String totalTaxAmount;
//   String servedBy;
//   String tillNumber;
//   String paymentMethod;
//
//   PurchaseData({
//     required this.receiptId,
//     required this.customerId,
//     required this.supermarketId,
//     required this.branch,
//     required this.receiptDate,
//     required this.totalAmount,
//     required this.currencyCode,
//     required this.receiptNumber,
//     required this.totalNoOfProducts,
//     required this.totalTaxAmount,
//     required this.servedBy,
//     required this.tillNumber,
//     required this.paymentMethod,
//   });
//
//   factory PurchaseData.fromJson(Map<String, dynamic> json) => PurchaseData(
//     receiptId: json["receipt_id"],
//     customerId: json["customer_id"],
//     supermarketId: json["supermarket_id"],
//     branch: json["branch"],
//     receiptDate: json["receipt_date"] == null ? null : json["receipt_date"],
//     totalAmount: json["total_amount"],
//     currencyCode: json["currency_code"],
//     receiptNumber: json["receipt_number"],
//     totalNoOfProducts: json["total_no_of_products"],
//     totalTaxAmount: json["total_tax_amount"],
//     servedBy: json["served_by"],
//     tillNumber: json["till_number"],
//     paymentMethod: json["payment_method"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "receipt_id": receiptId,
//     "customer_id": customerId,
//     "supermarket_id": supermarketId,
//     "branch": branch,
//     "receipt_date": receiptDate,
//     "total_amount": totalAmount,
//     "currency_code": currencyCode,
//     "receipt_number": receiptNumber,
//     "total_no_of_products": totalNoOfProducts,
//     "total_tax_amount": totalTaxAmount,
//     "served_by": servedBy,
//     "till_number": tillNumber,
//     "payment_method": paymentMethod,
//   };
// }


// To parse this JSON data, do
//
//     final purchaseHistoryResponse = purchaseHistoryResponseFromJson(jsonString);

import 'dart:convert';

PurchaseHistoryResponse purchaseHistoryResponseFromJson(String str) => PurchaseHistoryResponse.fromJson(json.decode(str));

String purchaseHistoryResponseToJson(PurchaseHistoryResponse data) => json.encode(data.toJson());

class PurchaseHistoryResponse {
  bool success;
  int statusCode;
  List<PurchaseData> data;
  int totalPages;

  PurchaseHistoryResponse({
    required this.success,
    required this.statusCode,
    required this.data,
    required this.totalPages,
  });

  factory PurchaseHistoryResponse.fromJson(Map<String, dynamic> json) => PurchaseHistoryResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: List<PurchaseData>.from(json["data"].map((x) => PurchaseData.fromJson(x))),
    totalPages: json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total_pages": totalPages,
  };
}

class PurchaseData {
  int receiptId;
  int customerId;
  int supermarketId;
  String supermarketName;
  String branch;
  String receiptDate;
  String totalAmount;
  String currencyCode;
  String receiptNumber;
  int totalNoOfProducts;
  String totalTaxAmount;
  String servedBy;
  String tillNumber;
  String paymentMethod;

  PurchaseData({
    required this.receiptId,
    required this.customerId,
    required this.supermarketId,
    required this.supermarketName,
    required this.branch,
    required this.receiptDate,
    required this.totalAmount,
    required this.currencyCode,
    required this.receiptNumber,
    required this.totalNoOfProducts,
    required this.totalTaxAmount,
    required this.servedBy,
    required this.tillNumber,
    required this.paymentMethod,
  });

  factory PurchaseData.fromJson(Map<String, dynamic> json) => PurchaseData(
    receiptId: json["receipt_id"],
    customerId: json["customer_id"],
    supermarketId: json["supermarket_id"],
    supermarketName: json["supermarket_name"],
    branch: json["branch"],
    receiptDate: json["receipt_date"],
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
    "supermarket_name": supermarketName,
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
