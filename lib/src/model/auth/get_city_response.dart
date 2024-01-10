
import 'dart:convert';

GetCityResponse getCityResponseFromJson(String str) => GetCityResponse.fromJson(json.decode(str));

String getCityResponseToJson(GetCityResponse data) => json.encode(data.toJson());

class GetCityResponse {
  final bool success;
  final int statusCode;
  final List<CityData> data;

  GetCityResponse({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory GetCityResponse.fromJson(Map<String, dynamic> json) => GetCityResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: List<CityData>.from(json["data"].map((x) => CityData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CityData {
  final int cityId;
  final String city;
  final String cityArabic;
  final String countryId;

  CityData({
    required this.cityId,
    required this.city,
    required this.cityArabic,
    required this.countryId,
  });

  factory CityData.fromJson(Map<String, dynamic> json) => CityData(
    cityId: json["city_id"],
    city: json["city"],
    cityArabic: json["city_arabic"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "city": city,
    "city_arabic": cityArabic,
    "country_id": countryId,
  };
}
