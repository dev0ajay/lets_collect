// To parse this JSON data, do
//
//     final purchaseHistoryDetailsResponse = purchaseHistoryDetailsResponseFromJson(jsonString);

import 'dart:convert';

PurchaseHistoryDetailsResponse purchaseHistoryDetailsResponseFromJson(String str) => PurchaseHistoryDetailsResponse.fromJson(json.decode(str));

String purchaseHistoryDetailsResponseToJson(PurchaseHistoryDetailsResponse data) => json.encode(data.toJson());

class PurchaseHistoryDetailsResponse {
  bool? success;
  int? statusCode;
  Data? data;

  PurchaseHistoryDetailsResponse({
    this.success,
    this.statusCode,
    this.data,
  });

  factory PurchaseHistoryDetailsResponse.fromJson(Map<String, dynamic> json) => PurchaseHistoryDetailsResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data?.toJson(),
  };
}

class Data {
  ReceiptData? receiptData;
  List<ItemDatum>? itemData;

  Data({
    this.receiptData,
    this.itemData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    receiptData: json["receipt_data"] == null ? null : ReceiptData.fromJson(json["receipt_data"]),
    itemData: json["item_data"] == null ? [] : List<ItemDatum>.from(json["item_data"]!.map((x) => ItemDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "receipt_data": receiptData?.toJson(),
    "item_data": itemData == null ? [] : List<dynamic>.from(itemData!.map((x) => x.toJson())),
  };
}

class ItemDatum {
  int? id;
  int? receiptId;
  String? itemName;
  String? code;
  String? brandName;
  String? itemPrice;
  int? quatity;
  String? totalPrice;

  ItemDatum({
    this.id,
    this.receiptId,
    this.itemName,
    this.code,
    this.brandName,
    this.itemPrice,
    this.quatity,
    this.totalPrice,
  });

  factory ItemDatum.fromJson(Map<String, dynamic> json) => ItemDatum(
    id: json["id"],
    receiptId: json["receipt_id"],
    itemName: json["item_name"],
    code: json["code"],
    brandName: json["brand_name"],
    itemPrice: json["item_price"],
    quatity: json["quatity"],
    totalPrice: json["total_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "receipt_id": receiptId,
    "item_name": itemName,
    "code": code,
    "brand_name": brandName,
    "item_price": itemPrice,
    "quatity": quatity,
    "total_price": totalPrice,
  };
}

class ReceiptData {
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

  ReceiptData({
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

  factory ReceiptData.fromJson(Map<String, dynamic> json) => ReceiptData(
    receiptId: json["receipt_id"],
    customerId: json["customer_id"],
    supermarketId: json["supermarket_id"],
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
