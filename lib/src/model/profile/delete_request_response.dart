// To parse this JSON data, do
//
//     final deleteAccountRequestResponse = deleteAccountRequestResponseFromJson(jsonString);

import 'dart:convert';

DeleteAccountRequestResponse deleteAccountRequestResponseFromJson(String str) => DeleteAccountRequestResponse.fromJson(json.decode(str));

String deleteAccountRequestResponseToJson(DeleteAccountRequestResponse data) => json.encode(data.toJson());

class DeleteAccountRequestResponse {
  final bool success;
  final int statusCode;
  final String message;

  DeleteAccountRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  factory DeleteAccountRequestResponse.fromJson(Map<String, dynamic> json) => DeleteAccountRequestResponse(
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
