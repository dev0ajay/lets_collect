

import 'dart:convert';

LanguageSelectionResponse languageSelectionResponseFromJson(String str) => LanguageSelectionResponse.fromJson(json.decode(str));

String languageSelectionResponseToJson(LanguageSelectionResponse data) => json.encode(data.toJson());

class LanguageSelectionResponse {
  final bool? status;
  final bool? data;
  final String? message;
  final String? messageArabic;

  LanguageSelectionResponse({
    this.status,
    this.data,
    this.message,
    this.messageArabic,
  });

  factory LanguageSelectionResponse.fromJson(Map<String, dynamic> json) => LanguageSelectionResponse(
    status: json["status"],
    data: json["data"],
    message: json["message"],
    messageArabic: json["message_arabic"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
    "message": message,
    "message_arabic": messageArabic,
  };
}
