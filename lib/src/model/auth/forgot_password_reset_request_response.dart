// To parse this JSON data, do
//
//     final forgotPasswordResetRequestResponse = forgotPasswordResetRequestResponseFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResetRequestResponse forgotPasswordResetRequestResponseFromJson(String str) => ForgotPasswordResetRequestResponse.fromJson(json.decode(str));

String forgotPasswordResetRequestResponseToJson(ForgotPasswordResetRequestResponse data) => json.encode(data.toJson());

class ForgotPasswordResetRequestResponse {
  final bool success;
  final int statusCode;
  final String message;
  final String messageArabic;

  ForgotPasswordResetRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.messageArabic,
  });

  factory ForgotPasswordResetRequestResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordResetRequestResponse(
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