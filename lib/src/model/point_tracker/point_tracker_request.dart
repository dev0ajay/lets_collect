import 'dart:convert';

PointTrackerRequest pointTrackerRequestFromJson(String str) => PointTrackerRequest.fromJson(json.decode(str));

String pointTrackerRequestToJson(PointTrackerRequest data) => json.encode(data.toJson());

class PointTrackerRequest {
  final String sort;
  final String superMarketId;
  final String month;
  final String year;

  PointTrackerRequest({
    required this.sort,
    required this.superMarketId,
    required this.month,
    required this.year,
  });

  factory PointTrackerRequest.fromJson(Map<String, dynamic> json) => PointTrackerRequest(
    sort: json["sort"],
    superMarketId: json["super_market_id"],
    month: json["month"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "sort": sort,
    "super_market_id": superMarketId,
    "month": month,
    "year": year,
  };
}
