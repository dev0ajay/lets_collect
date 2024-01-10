
import 'dart:convert';

SignUpRequestErrorResponse signUpRequestErrorResponseFromJson(String str) => SignUpRequestErrorResponse.fromJson(json.decode(str));

String signUpRequestErrorResponseToJson(SignUpRequestErrorResponse data) => json.encode(data.toJson());

class SignUpRequestErrorResponse {
  final bool status;
  final int statusCode;
  final String message;
  final Data data;
  final String token;

  SignUpRequestErrorResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.token,
  });

  factory SignUpRequestErrorResponse.fromJson(Map<String, dynamic> json) => SignUpRequestErrorResponse(
    status: json["status"],
    statusCode: json["status_code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
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
    email: json["email"] == null ? null : json["email"],
    mobileNo: json["mobile_no"] == null ? null : json["mobile_no"],
    userName: json["user_name"] == null ? null : json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "mobile_no": mobileNo == null ? null : mobileNo,
    "user_name": userName == null ? null : userName,
  };
}
