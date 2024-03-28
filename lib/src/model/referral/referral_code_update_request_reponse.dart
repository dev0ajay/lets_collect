import 'dart:convert';

ReferralCodeUpdateRequestResponse referralCodeUpdateRequestResponseFromJson(String str) => ReferralCodeUpdateRequestResponse.fromJson(json.decode(str));

String referralCodeUpdateRequestResponseToJson(ReferralCodeUpdateRequestResponse data) => json.encode(data.toJson());

class ReferralCodeUpdateRequestResponse {
  bool success;
  int statusCode;
  String message;

  ReferralCodeUpdateRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  factory ReferralCodeUpdateRequestResponse.fromJson(Map<String, dynamic> json) => ReferralCodeUpdateRequestResponse(
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
