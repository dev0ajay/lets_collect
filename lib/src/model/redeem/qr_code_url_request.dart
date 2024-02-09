// To parse this JSON data, do
//
//     final qrCodeUrlRequest = qrCodeUrlRequestFromJson(jsonString);

import 'dart:convert';

QrCodeUrlRequest qrCodeUrlRequestFromJson(String str) => QrCodeUrlRequest.fromJson(json.decode(str));

String qrCodeUrlRequestToJson(QrCodeUrlRequest data) => json.encode(data.toJson());

class QrCodeUrlRequest {
  final int rewardId;

  QrCodeUrlRequest({
   required this.rewardId,
  });

  factory QrCodeUrlRequest.fromJson(Map<String, dynamic> json) => QrCodeUrlRequest(
    rewardId: json["reward_id"],
  );

  Map<String, dynamic> toJson() => {
    "reward_id": rewardId,
  };
}
