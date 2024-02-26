
import 'dart:convert';

PurchaseHistoryRequest purchaseHistoryRequestFromJson(String str) => PurchaseHistoryRequest.fromJson(json.decode(str));

String purchaseHistoryRequestToJson(PurchaseHistoryRequest data) => json.encode(data.toJson());

class PurchaseHistoryRequest {
  final String sort;
  final String supermarketId;
  final String month;
  final String year;
  final String page;

  PurchaseHistoryRequest({
    required this.sort,
    required this.supermarketId,
    required this.month,
    required this.year,
    required this.page,
  });

  factory PurchaseHistoryRequest.fromJson(Map<String, dynamic> json) => PurchaseHistoryRequest(
    sort: json["sort"],
    supermarketId: json["supermarket_id"],
    month: json["month"],
    year: json["year"],
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "sort": sort,
    "supermarket_id": supermarketId,
    "month": month,
    "year": year,
    "page": page,
  };
}
