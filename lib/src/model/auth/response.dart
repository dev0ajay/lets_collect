
import 'dart:convert';

SignUpRequestResponse signUpRequestResponseFromJson(String str) => SignUpRequestResponse.fromJson(json.decode(str));

String signUpRequestResponseToJson(SignUpRequestResponse data) => json.encode(data.toJson());

class SignUpRequestResponse {
  final bool success;
  final int statusCode;
  final String message;
  final Data data;
  final String token;

  SignUpRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.token,
  });

  factory SignUpRequestResponse.fromJson(Map<String, dynamic> json) => SignUpRequestResponse(
    success: json["success"] ?? false,
    statusCode: json["status_code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "message": message,
    "data": data.toJson(),
    "token": token,
  };
}

class Data {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNo;
  final String userName;
  final String gender;
  final String dob;
  final String nationalityId;
  final String city;
  final String countryId;
  final int status;
  final String createdAt;

  Data({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNo,
    required this.userName,
    required this.gender,
    required this.dob,
    required this.nationalityId,
    required this.city,
    required this.countryId,
    required this.status,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    // id: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] ?? "null",
    lastName: json["last_name"] ?? "null",
    email: json["email"] ?? "null",
    mobileNo: json["mobile_no"] ?? "null",
    userName: json["user_name"] ?? "null",
    gender: json["gender"] ?? "null",
    dob: json["dob"] ?? "null",
    nationalityId: json["nationality_id"] ?? "null",
    city: json["city"] ?? "null",
    countryId: json["country_id"] ?? "null",
    createdAt: json["created_at"] ?? "null",
    status: json["status"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    // "id": id == null ? null : id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "mobile_no": mobileNo,
    "user_name": userName,
    "gender": gender,
    "dob": dob,
    "nationality_id": nationalityId,
    "city": city,
    "country_id": countryId,
    "created_at": createdAt,
    "status": status,
  };
}
