// To parse this JSON data, do
//
//     final forgotPasswordResetRequestResponse = forgotPasswordResetRequestResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ForgotPasswordResetRequestResponse forgotPasswordResetRequestResponseFromJson(String str) => ForgotPasswordResetRequestResponse.fromJson(json.decode(str));

String forgotPasswordResetRequestResponseToJson(ForgotPasswordResetRequestResponse data) => json.encode(data.toJson());

class ForgotPasswordResetRequestResponse {
  final bool success;
  final int statusCode;
  final String message;

  ForgotPasswordResetRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  factory ForgotPasswordResetRequestResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordResetRequestResponse(
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
