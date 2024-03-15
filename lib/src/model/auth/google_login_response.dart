// To parse this JSON data, do
//
//     final googleLoginResponse = googleLoginResponseFromJson(jsonString);

import 'dart:convert';

GoogleLoginResponse googleLoginResponseFromJson(String str) => GoogleLoginResponse.fromJson(json.decode(str));

String googleLoginResponseToJson(GoogleLoginResponse data) => json.encode(data.toJson());

class GoogleLoginResponse {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;
  String? token;

  GoogleLoginResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
    this.token,
  });

  factory GoogleLoginResponse.fromJson(Map<String, dynamic> json) => GoogleLoginResponse(
    success: json["success"],
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
    "token": token,
  };
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? userName;
  String? gender;
  String? dob;
  String? nationalityId;
  String? city;
  String? countryId;
  String? createdAt;
  int? status;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNo,
    this.userName,
    this.gender,
    this.dob,
    this.nationalityId,
    this.city,
    this.countryId,
    this.createdAt,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    mobileNo: json["mobile_no"],
    userName: json["user_name"],
    gender: json["gender"],
    dob: json["dob"],
    nationalityId: json["nationality_id"],
    city: json["city"],
    countryId: json["country_id"],
    createdAt: json["created_at"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
