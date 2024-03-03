import 'dart:convert';

PointTrackerDetailsRequest pointTrackerDetailsRequestFromJson(String str) => PointTrackerDetailsRequest.fromJson(json.decode(str));

String pointTrackerDetailsRequestToJson(PointTrackerDetailsRequest data) => json.encode(data.toJson());

class PointTrackerDetailsRequest {
  final int pointId;

  PointTrackerDetailsRequest({
    required this.pointId,
  });

  factory PointTrackerDetailsRequest.fromJson(Map<String, dynamic> json) => PointTrackerDetailsRequest(
    pointId: json["point_id"],
  );

  Map<String, dynamic> toJson() => {
    "point_id": pointId,
  };
}
