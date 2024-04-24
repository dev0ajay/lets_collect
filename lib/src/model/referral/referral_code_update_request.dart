import 'dart:convert';

ReferralCodeUpdateRequest referralCodeUpdateRequestFromJson(String str) => ReferralCodeUpdateRequest.fromJson(json.decode(str));

String referralCodeUpdateRequestToJson(ReferralCodeUpdateRequest data) => json.encode(data.toJson());

class ReferralCodeUpdateRequest {
  String referralCode;
  String language;

  ReferralCodeUpdateRequest({
    required this.referralCode,
    required this.language,
  });

  factory ReferralCodeUpdateRequest.fromJson(Map<String, dynamic> json) => ReferralCodeUpdateRequest(
    referralCode: json["referral_code"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "referral_code": referralCode,
    "language": language,
  };
}