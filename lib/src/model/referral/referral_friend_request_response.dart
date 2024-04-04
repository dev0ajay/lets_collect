import 'dart:convert';

ReferralFriendRequestResponse referralFriendRequestResponseFromJson(String str) => ReferralFriendRequestResponse.fromJson(json.decode(str));

String referralFriendRequestResponseToJson(ReferralFriendRequestResponse data) => json.encode(data.toJson());

class ReferralFriendRequestResponse {
  bool success;
  int statusCode;
  String message;

  ReferralFriendRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  factory ReferralFriendRequestResponse.fromJson(Map<String, dynamic> json) => ReferralFriendRequestResponse(
    success: json["success"],
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "message": message,
  };
}
