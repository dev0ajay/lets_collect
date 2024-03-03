class PurchaseHistoryDetailsResponse {
  final bool success;
  final int statusCode;
  final Data data;

  PurchaseHistoryDetailsResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory PurchaseHistoryDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseHistoryDetailsResponse(
      success: json["success"] ?? false,
      statusCode: json["status_code"] ?? 0,
      data: Data.fromJson(json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data.toJson(),
  };
}

class Data {
  final ReceiptData receiptData;
  final List<ItemDatum> itemData;

  Data({
    required this.receiptData,
    required this.itemData,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      receiptData: ReceiptData.fromJson(json["receipt_data"] ?? {}),
      itemData: (json["item_data"] as List<dynamic>?)
          ?.map((item) => ItemDatum.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    "receipt_data": receiptData.toJson(),
    "item_data": List<dynamic>.from(itemData.map((x) => x.toJson())),
  };
}

class ItemDatum {
  final int id;
  final int receiptId;
  final String itemName;
  final String code;
  final String brandName;
  final String itemPrice;
  final int quantity;
  final String totalPrice;

  ItemDatum({
    required this.id,
    required this.receiptId,
    required this.itemName,
    required this.code,
    required this.brandName,
    required this.itemPrice,
    required this.quantity,
    required this.totalPrice,
  });

  factory ItemDatum.fromJson(Map<String, dynamic> json) {
    return ItemDatum(
      id: json["id"] ?? 0,
      receiptId: json["receipt_id"] ?? 0,
      itemName: json["item_name"] ?? "",
      code: json["code"] ?? "",
      brandName: json["brand_name"] ?? "",
      itemPrice: json["item_price"] ?? "",
      quantity: json["quantity"] ?? 0,
      totalPrice: json["total_price"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "receipt_id": receiptId,
    "item_name": itemName,
    "code": code,
    "brand_name": brandName,
    "item_price": itemPrice,
    "quantity": quantity,
    "total_price": totalPrice,
  };
}

class ReceiptData {
  final int receiptId;
  final int customerId;
  final int supermarketId;
  final String branch;
  final String receiptDate;
  final String totalAmount;
  final String currencyCode;
  final String receiptNumber;
  final int totalNoOfProducts;
  final String totalTaxAmount;
  final String servedBy;
  final String tillNumber;
  final String paymentMethod;

  ReceiptData({
    required this.receiptId,
    required this.customerId,
    required this.supermarketId,
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

  factory ReceiptData.fromJson(Map<String, dynamic> json) {
    return ReceiptData(
      receiptId: json["receipt_id"] ?? 0,
      customerId: json["customer_id"] ?? 0,
      supermarketId: json["supermarket_id"] ?? 0,
      branch: json["branch"] ?? "",
      receiptDate: json["receipt_date"] ?? "",
      totalAmount: json["total_amount"] ?? "",
      currencyCode: json["currency_code"] ?? "",
      receiptNumber: json["receipt_number"] ?? "",
      totalNoOfProducts: json["total_no_of_products"] ?? 0,
      totalTaxAmount: json["total_tax_amount"] ?? "",
      servedBy: json["served_by"] ?? "",
      tillNumber: json["till_number"] ?? "",
      paymentMethod: json["payment_method"] ?? "",
    );
  }

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
