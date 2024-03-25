// To parse this JSON data, do
//
//     final contactUsRequest = contactUsRequestFromJson(jsonString);

import 'dart:convert';

ContactUsRequest contactUsRequestFromJson(String str) => ContactUsRequest.fromJson(json.decode(str));

String contactUsRequestToJson(ContactUsRequest data) => json.encode(data.toJson());

class ContactUsRequest {
  String subject;
  String message;
  String supportPicture;

  ContactUsRequest({
    required this.subject,
    required this.message,
    required this.supportPicture,
  });

  factory ContactUsRequest.fromJson(Map<String, dynamic> json) => ContactUsRequest(
    subject: json["subject"],
    message: json["message"],
    supportPicture: json["support_picture"],
  );

  Map<String, dynamic> toJson() => {
    "subject": subject,
    "message": message,
    "support_picture": supportPicture,
  };
}