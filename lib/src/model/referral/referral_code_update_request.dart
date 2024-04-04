import 'dart:convert';

ReferralCodeUpdateRequest referralCodeUpdateRequestFromJson(String str) => ReferralCodeUpdateRequest.fromJson(json.decode(str));

String referralCodeUpdateRequestToJson(ReferralCodeUpdateRequest data) => json.encode(data.toJson());

class ReferralCodeUpdateRequest {
  String referralCode;

  ReferralCodeUpdateRequest({
    required this.referralCode,
  });

  factory ReferralCodeUpdateRequest.fromJson(Map<String, dynamic> json) => ReferralCodeUpdateRequest(
    referralCode: json["referral_code"],
  );

  Map<String, dynamic> toJson() => {
    "referral_code": referralCode,
  };
}
