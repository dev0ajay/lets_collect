
import 'dart:convert';

SuperMarketListResponse superMarketListResponseFromJson(String str) => SuperMarketListResponse.fromJson(json.decode(str));

String superMarketListResponseToJson(SuperMarketListResponse data) => json.encode(data.toJson());

class SuperMarketListResponse {
  bool? success;
  int? statusCode;
  List<Datum>? data;

  SuperMarketListResponse({
    this.success,
    this.statusCode,
    this.data,
  });

  factory SuperMarketListResponse.fromJson(Map<String, dynamic> json) => SuperMarketListResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? supermarketName;

  Datum({
    this.id,
    this.supermarketName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    supermarketName: json["supermarket_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "supermarket_name": supermarketName,
  };
}
