import 'dart:convert';

PurchaseHistoryDetailsRequest purchaseHistoryDetailsRequestFromJson(String str) => PurchaseHistoryDetailsRequest.fromJson(json.decode(str));

String purchaseHistoryDetailsRequestToJson(PurchaseHistoryDetailsRequest data) => json.encode(data.toJson());

class PurchaseHistoryDetailsRequest {
  final String purchaseId;

  PurchaseHistoryDetailsRequest({
    required this.purchaseId,
  });

  factory PurchaseHistoryDetailsRequest.fromJson(Map<String, dynamic> json) => PurchaseHistoryDetailsRequest(
    purchaseId: json["purchase_id"],
  );

  Map<String, dynamic> toJson() => {
    "purchase_id": purchaseId,
  };
}
