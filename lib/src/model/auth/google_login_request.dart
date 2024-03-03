
import 'dart:convert';

GoogleLoginRequest googleLoginRequestFromJson(String str) => GoogleLoginRequest.fromJson(json.decode(str));

String googleLoginRequestToJson(GoogleLoginRequest data) => json.encode(data.toJson());

class GoogleLoginRequest {
  final String email;
  final String displayName;
  final String mobileNo;
  final String deviceToken;
  final String deviceType;

  GoogleLoginRequest({
    required this.email,
    required this.displayName,
    required this.mobileNo,
    required this.deviceToken,
    required this.deviceType,
  });

  factory GoogleLoginRequest.fromJson(Map<String, dynamic> json) => GoogleLoginRequest(
    email: json["email"],
    displayName: json["display_name"],
    mobileNo: json["mobile_no"],
    deviceToken: json["device_token"],
    deviceType: json["device_type"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "display_name": displayName,
    "mobile_no": mobileNo,
    "device_token": deviceToken,
    "device_type": deviceType,
  };
}
