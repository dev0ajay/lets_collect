// To parse this JSON data, do
//
//     final forgotPasswordResetRequest = forgotPasswordResetRequestFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResetRequest forgotPasswordResetRequestFromJson(String str) => ForgotPasswordResetRequest.fromJson(json.decode(str));

String forgotPasswordResetRequestToJson(ForgotPasswordResetRequest data) => json.encode(data.toJson());

class ForgotPasswordResetRequest {
  final String password;
  final String passwordConfirmation;

  ForgotPasswordResetRequest({
    required this.password,
    required this.passwordConfirmation,
  });

  factory ForgotPasswordResetRequest.fromJson(Map<String, dynamic> json) => ForgotPasswordResetRequest(
    password: json["password"],
    passwordConfirmation: json["password_confirmation"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "password_confirmation": passwordConfirmation,
  };
}
