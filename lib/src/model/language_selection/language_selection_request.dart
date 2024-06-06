
import 'dart:convert';

LanguageSelectionRequest languageSelectionRequestFromJson(String str) => LanguageSelectionRequest.fromJson(json.decode(str));

String languageSelectionRequestToJson(LanguageSelectionRequest data) => json.encode(data.toJson());

class LanguageSelectionRequest {
  final String language;

  LanguageSelectionRequest({
    required this.language,
  });

  factory LanguageSelectionRequest.fromJson(Map<String, dynamic> json) => LanguageSelectionRequest(
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "language": language,
  };
}
