
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
    success: json["success"] == null ? false : json["success"],
    statusCode: json["status_code"] == null ? null : json["status_code"],
    message: json["message"] == null ? null : json["message"],
    data: Data.fromJson(json["data"]),
    token: json["token"] == null ? null : json["token"],
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
    firstName: json["first_name"] == null ? "null" : json["first_name"],
    lastName: json["last_name"] == null ? "null" : json["last_name"],
    email: json["email"] == null ? "null" : json["email"],
    mobileNo: json["mobile_no"] == null ? "null" : json["mobile_no"],
    userName: json["user_name"] == null ? "null" : json["user_name"],
    gender: json["gender"] == null ? "null" : json["gender"],
    dob: json["dob"] == null ? "null" : json["dob"],
    nationalityId: json["nationality_id"] == null ? "null" : json["nationality_id"],
    city: json["city"] == null ? "null" : json["city"],
    countryId: json["country_id"] == null ? "null" : json["country_id"],
    createdAt: json["created_at"] == null ? "null" : json["created_at"],
    status: json["status"] == null ? 0 : json["status"],
  );

  Map<String, dynamic> toJson() => {
    // "id": id == null ? null : id,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "email": email == null ? null : email,
    "mobile_no": mobileNo == null ? null : mobileNo,
    "user_name": userName == null ? null : userName,
    "gender": gender == null ? null : gender,
    "dob": dob == null ? null : dob,
    "nationality_id": nationalityId == null ? null : nationalityId,
    "city": city == null ? null : city,
    "country_id": countryId == null ? null : countryId,
    "created_at": createdAt == null ? null : createdAt,
    "status": status == null ? null : status,
  };
}
