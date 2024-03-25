// To parse this JSON data, do
//
//     final contactUsRequestResponse = contactUsRequestResponseFromJson(jsonString);

import 'dart:convert';

ContactUsRequestResponse contactUsRequestResponseFromJson(String str) => ContactUsRequestResponse.fromJson(json.decode(str));

String contactUsRequestResponseToJson(ContactUsRequestResponse data) => json.encode(data.toJson());

class ContactUsRequestResponse {
  bool success;
  int statusCode;
  String message;

  ContactUsRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  factory ContactUsRequestResponse.fromJson(Map<String, dynamic> json) => ContactUsRequestResponse(
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