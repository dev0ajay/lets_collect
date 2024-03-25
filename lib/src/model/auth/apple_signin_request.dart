
import 'dart:convert';

AppleSignInRequest appleSignInRequestFromJson(String str) => AppleSignInRequest.fromJson(json.decode(str));

String appleSignInRequestToJson(AppleSignInRequest data) => json.encode(data.toJson());

class AppleSignInRequest {
  final String email;
  final String displayName;
  final String mobileNo;
  final String appleKey;
  final String deviceToken;
  final String deviceType;

  AppleSignInRequest({
    required this.email,
    required this.displayName,
    required this.mobileNo,
    required this.appleKey,
    required this.deviceToken,
    required this.deviceType,
  });

  factory AppleSignInRequest.fromJson(Map<String, dynamic> json) => AppleSignInRequest(
    email: json["email"],
    displayName: json["display_name"],
    mobileNo: json["mobile_no"],
    appleKey: json["apple_key"],
    deviceToken: json["device_token"],
    deviceType: json["device_type"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "display_name": displayName,
    "mobile_no": mobileNo,
    "apple_key": appleKey,
    "device_token": deviceToken,
    "device_type": deviceType,
  };
}
