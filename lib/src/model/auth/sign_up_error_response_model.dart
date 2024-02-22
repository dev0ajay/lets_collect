
import 'dart:convert';

SignUpRequestErrorResponse signUpRequestErrorResponseFromJson(String str) => SignUpRequestErrorResponse.fromJson(json.decode(str));

String signUpRequestErrorResponseToJson(SignUpRequestErrorResponse data) => json.encode(data.toJson());

class SignUpRequestErrorResponse {
  final bool success;
  final int statusCode;
  final String message;
  final Data data;
  final String token;

  SignUpRequestErrorResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.token,
  });

  factory SignUpRequestErrorResponse.fromJson(Map<String, dynamic> json) => SignUpRequestErrorResponse(
    success: json["success"],
    statusCode: json["status_code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": success,
    "status_code": statusCode,
    "message": message,
    "data": data.toJson(),
    "token": token,
  };
}

class Data {
   String? email;
   String? mobileNo;
   String? userName;

  Data({
    required this.email,
    required this.mobileNo,
    required this.userName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"] ?? "",
    mobileNo: json["mobile_no"] ?? "",
    userName: json["user_name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "email": email ?? "",
    "mobile_no": mobileNo ?? "",
    "user_name": userName ?? "",
  };
}
