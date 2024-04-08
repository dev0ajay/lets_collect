
import 'dart:convert';

ChangePasswordRequestResponse changePasswordRequestResponseFromJson(String str) => ChangePasswordRequestResponse.fromJson(json.decode(str));

String changePasswordRequestResponseToJson(ChangePasswordRequestResponse data) => json.encode(data.toJson());

class ChangePasswordRequestResponse {
  bool success;
  int statusCode;
  String message;
  String messageArabic;

  ChangePasswordRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.messageArabic,
  });

  factory ChangePasswordRequestResponse.fromJson(Map<String, dynamic> json) => ChangePasswordRequestResponse(
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