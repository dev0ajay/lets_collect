
import 'dart:convert';

ForgotPasswordOtpRequestResponse forgotPasswordOtpRequestResponseFromJson(String str) => ForgotPasswordOtpRequestResponse.fromJson(json.decode(str));

String forgotPasswordOtpRequestResponseToJson(ForgotPasswordOtpRequestResponse data) => json.encode(data.toJson());

class ForgotPasswordOtpRequestResponse {
  final bool success;
  final int statusCode;
  final String message;
  final String messageArabic;
  final String token;

  ForgotPasswordOtpRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.messageArabic,
    required this.token,
  });

  factory ForgotPasswordOtpRequestResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordOtpRequestResponse(
    success: json["success"],
    statusCode: json["status_code"],
    message: json["message"],
    messageArabic: json["message_arabic"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "message": message,
    "message_arabic": messageArabic,
    "token": token,
  };
}