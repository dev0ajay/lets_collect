
import 'dart:convert';

GetCityRequest getCityRequestFromJson(String str) => GetCityRequest.fromJson(json.decode(str));

String getCityRequestToJson(GetCityRequest data) => json.encode(data.toJson());

class GetCityRequest {
  final int countriesId;

  GetCityRequest({
    required this.countriesId,
  });

  factory GetCityRequest.fromJson(Map<String, dynamic> json) => GetCityRequest(
    countriesId: json["countries_id"],
  );

  Map<String, dynamic> toJson() => {
    "countries_id": countriesId,
  };
}
