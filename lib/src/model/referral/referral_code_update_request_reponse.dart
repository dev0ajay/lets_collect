import 'dart:convert';

ReferralCodeUpdateRequestResponse referralCodeUpdateRequestResponseFromJson(String str) => ReferralCodeUpdateRequestResponse.fromJson(json.decode(str));

String referralCodeUpdateRequestResponseToJson(ReferralCodeUpdateRequestResponse data) => json.encode(data.toJson());

class ReferralCodeUpdateRequestResponse {
  bool success;
  int statusCode;
  String message;
  final String messageArabic;

  ReferralCodeUpdateRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.messageArabic,
  });

  factory ReferralCodeUpdateRequestResponse.fromJson(Map<String, dynamic> json) => ReferralCodeUpdateRequestResponse(
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