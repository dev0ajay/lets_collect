
import 'dart:convert';

ScanReceiptHistoryRequest scanReceiptHistoryRequestFromJson(String str) => ScanReceiptHistoryRequest.fromJson(json.decode(str));

String scanReceiptHistoryRequestToJson(ScanReceiptHistoryRequest data) => json.encode(data.toJson());

class ScanReceiptHistoryRequest {
  final int pointId;

  ScanReceiptHistoryRequest({
    required this.pointId,
  });

  factory ScanReceiptHistoryRequest.fromJson(Map<String, dynamic> json) => ScanReceiptHistoryRequest(
    pointId: json["point_id"],
  );

  Map<String, dynamic> toJson() => {
    "point_id": pointId,
  };
}
