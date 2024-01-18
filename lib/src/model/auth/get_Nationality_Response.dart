
import 'dart:convert';

NationalityResponse nationalityResponseFromJson(String str) => NationalityResponse.fromJson(json.decode(str));

String nationalityResponseToJson(NationalityResponse data) => json.encode(data.toJson());

class NationalityResponse {
  final bool success;
  final int statusCode;
  final List<Datum> data;

  NationalityResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory NationalityResponse.fromJson(Map<String, dynamic> json) => NationalityResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final String nationality;
  final String nationalityArabic;

  Datum({
    required this.id,
    required this.nationality,
    required this.nationalityArabic,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    nationality: json["nationality"],
    nationalityArabic: json["nationality_arabic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nationality": nationality,
    "nationality_arabic": nationalityArabic,
  };
}
