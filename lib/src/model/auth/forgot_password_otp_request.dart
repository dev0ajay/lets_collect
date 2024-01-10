
import 'dart:convert';

ForgotPasswordOtpRequest forgotPasswordOtpRequestFromJson(String str) => ForgotPasswordOtpRequest.fromJson(json.decode(str));

String forgotPasswordOtpRequestToJson(ForgotPasswordOtpRequest data) => json.encode(data.toJson());

class ForgotPasswordOtpRequest {
  final String email;
  final String otp;

  ForgotPasswordOtpRequest({
    required this.email,
    required this.otp,
  });

  factory ForgotPasswordOtpRequest.fromJson(Map<String, dynamic> json) => ForgotPasswordOtpRequest(
    email: json["email"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "otp": otp,
  };
}
