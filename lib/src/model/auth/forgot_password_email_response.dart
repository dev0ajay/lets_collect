
import 'dart:convert';

ForgotPasswordEmailRequestResponse forgotPasswordEmailRequestResponseFromJson(String str) => ForgotPasswordEmailRequestResponse.fromJson(json.decode(str));

String forgotPasswordEmailRequestResponseToJson(ForgotPasswordEmailRequestResponse data) => json.encode(data.toJson());

class ForgotPasswordEmailRequestResponse {
  final bool success;
  final int statusCode;
  final String message;

  ForgotPasswordEmailRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  factory ForgotPasswordEmailRequestResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordEmailRequestResponse(
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
