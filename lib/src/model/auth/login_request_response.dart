
import 'dart:convert';

LoginRequestResponse loginRequestResponseFromJson(String str) => LoginRequestResponse.fromJson(json.decode(str));

String loginRequestResponseToJson(LoginRequestResponse data) => json.encode(data.toJson());

class LoginRequestResponse {
  final bool success;
  final int statusCode;
  final String message;
  final Data data;
  final String token;

  LoginRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.token,
  });

  factory LoginRequestResponse.fromJson(Map<String, dynamic> json) => LoginRequestResponse(
    success: json["success"],
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
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobileNo;
  final String? userName;
  final String? gender;
  final String? dob;
  final int? nationalityId;
  final String? city;
  final int? countryId;
  final String? createdAt;
  final int? status;

  Data({
    required this.id,
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
    required this.createdAt,
    required this.status,
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
