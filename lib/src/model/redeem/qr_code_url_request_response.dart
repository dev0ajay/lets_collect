
import 'dart:convert';

QrCodeUrlRequestResponse qrCodeUrlRequestResponseFromJson(String str) => QrCodeUrlRequestResponse.fromJson(json.decode(str));

String qrCodeUrlRequestResponseToJson(QrCodeUrlRequestResponse data) => json.encode(data.toJson());

class QrCodeUrlRequestResponse {
  final bool? success;
  final Data? data;
  final String? message;

  QrCodeUrlRequestResponse({
    this.success,
    this.data,
    this.message,
  });

  factory QrCodeUrlRequestResponse.fromJson(Map<String, dynamic> json) => QrCodeUrlRequestResponse(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final String? url;
  final int? qrStatus;

  Data({
    this.url,
    this.qrStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    url: json["url"],
    qrStatus: json["qr_status"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "qr_status": qrStatus,
  };
}
