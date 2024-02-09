
import 'dart:convert';

ScanReceiptError scanReceiptErrorFromJson(String str) => ScanReceiptError.fromJson(json.decode(str));

String scanReceiptErrorToJson(ScanReceiptError data) => json.encode(data.toJson());

class ScanReceiptError {
  bool? success;
  String? message;
  Data? data;

  ScanReceiptError({
    this.success,
    this.message,
    this.data,
  });

  factory ScanReceiptError.fromJson(Map<String, dynamic> json) => ScanReceiptError(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
