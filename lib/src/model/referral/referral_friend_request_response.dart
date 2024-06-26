import 'dart:convert';

ReferralFriendRequestResponse referralFriendRequestResponseFromJson(String str) => ReferralFriendRequestResponse.fromJson(json.decode(str));

String referralFriendRequestResponseToJson(ReferralFriendRequestResponse data) => json.encode(data.toJson());

class ReferralFriendRequestResponse {
  bool success;
  int statusCode;
  String message;
  String messageArabic;

  ReferralFriendRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.messageArabic,
  });

  factory ReferralFriendRequestResponse.fromJson(Map<String, dynamic> json) => ReferralFriendRequestResponse(
    success: json["success"],
    statusCode: json["status_code"],
    message: json["message"],
    messageArabic: json["message_arabic"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "message": message,
    "message_arabic": messageArabic,
  };
}