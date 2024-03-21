// To parse this JSON data, do
//
//     final myProfileScreenResponse = myProfileScreenResponseFromJson(jsonString);

import 'dart:convert';

MyProfileScreenResponse myProfileScreenResponseFromJson(String str) => MyProfileScreenResponse.fromJson(json.decode(str));

String myProfileScreenResponseToJson(MyProfileScreenResponse data) => json.encode(data.toJson());

class MyProfileScreenResponse {
  bool? success;
  Data? data;
  String? message;

  MyProfileScreenResponse({
    this.success,
    this.data,
    this.message,
  });

  factory MyProfileScreenResponse.fromJson(Map<String, dynamic> json) => MyProfileScreenResponse(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? userName;
  String? gender;
  DateTime? dob;
  int? nationalityId;
  String? nationalityNameEn;
  String? countryNameEn;
  String? nationalityNameAr;
  String? countryNameAr;
  String? city;
  String? cityName;
  String? cityNameAr;
  int? countryId;
  int? status;
  String? photo;

  Data({
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNo,
    this.userName,
    this.gender,
    this.dob,
    this.nationalityId,
    this.nationalityNameEn,
    this.countryNameEn,
    this.nationalityNameAr,
    this.countryNameAr,
    this.city,
    this.cityName,
    this.cityNameAr,
    this.countryId,
    this.status,
    this.photo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    mobileNo: json["mobile_no"],
    userName: json["user_name"],
    gender: json["gender"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    nationalityId: json["nationality_id"],
    nationalityNameEn: json["nationality_name_en"],
    countryNameEn: json["country_name_en"],
    nationalityNameAr: json["nationality_name_ar"],
    countryNameAr: json["country_name_ar"],
    city: json["city"],
    cityName: json["city_name"],
    cityNameAr: json["city_name_ar"],
    countryId: json["country_id"],
    status: json["status"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "mobile_no": mobileNo,
    "user_name": userName,
    "gender": gender,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "nationality_id": nationalityId,
    "nationality_name_en": nationalityNameEn,
    "country_name_en": countryNameEn,
    "nationality_name_ar": nationalityNameAr,
    "country_name_ar": countryNameAr,
    "city": city,
    "city_name": cityName,
    "city_name_ar": cityNameAr,
    "country_id": countryId,
    "status": status,
    "photo": photo,
  };
}
