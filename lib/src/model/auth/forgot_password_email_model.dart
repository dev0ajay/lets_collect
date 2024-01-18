
import 'dart:convert';

ForgotPasswordEmailRequest forgotPasswordEmailRequestFromJson(String str) => ForgotPasswordEmailRequest.fromJson(json.decode(str));

String forgotPasswordEmailRequestToJson(ForgotPasswordEmailRequest data) => json.encode(data.toJson());

class ForgotPasswordEmailRequest {
  final String email;

  ForgotPasswordEmailRequest({
    required this.email,
  });

  factory ForgotPasswordEmailRequest.fromJson(Map<String, dynamic> json) => ForgotPasswordEmailRequest(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
