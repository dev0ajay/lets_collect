
import 'dart:convert';

CountryResponse countryResponseFromJson(String str) => CountryResponse.fromJson(json.decode(str));

String countryResponseToJson(CountryResponse data) => json.encode(data.toJson());

class CountryResponse {
  final bool success;
  final int statusCode;
  final List<CountryData> data;

  CountryResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) => CountryResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: List<CountryData>.from(json["data"].map((x) => CountryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CountryData {
  final int countriesId;
  final String countryCode;
  final String name;
  final String nameArabic;

  CountryData({
    required this.countriesId,
    required this.countryCode,
    required this.name,
    required this.nameArabic,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    countriesId: json["countries_id"],
    countryCode: json["country_code"],
    name: json["name"],
    nameArabic: json["name_arabic"],
  );

  Map<String, dynamic> toJson() => {
    "countries_id": countriesId,
    "country_code": countryCode,
    "name": name,
    "name_arabic": nameArabic,
  };
}
