
import 'dart:convert';

GoogleLoginRequest googleLoginRequestFromJson(String str) => GoogleLoginRequest.fromJson(json.decode(str));

String googleLoginRequestToJson(GoogleLoginRequest data) => json.encode(data.toJson());

class GoogleLoginRequest {
  final String email;
  final String deviceToken;
  final String deviceType;

  GoogleLoginRequest({
    required this.email,
    required this.deviceToken,
    required this.deviceType,
  });

  factory GoogleLoginRequest.fromJson(Map<String, dynamic> json) => GoogleLoginRequest(
    email: json["email"],
    deviceToken: json["device_token"],
    deviceType: json["device_type"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "device_token": deviceToken,
    "device_type": deviceType,
  };
}
