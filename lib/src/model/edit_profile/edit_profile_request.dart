// To parse this JSON data, do
//
//     final editProfileRequest = editProfileRequestFromJson(jsonString);

import 'dart:convert';

EditProfileRequest editProfileRequestFromJson(String str) => EditProfileRequest.fromJson(json.decode(str));

String editProfileRequestToJson(EditProfileRequest data) => json.encode(data.toJson());

class EditProfileRequest {
  String? photo;
  String? dob;
  String? gender;
  String? firstName;
  String? lastName;
  int? mobileNo;
  String? userName;
  int? nationalityId;
  String? city;
  int? status;
  int? countryId;

  EditProfileRequest({
    this.photo,
    this.dob,
    this.gender,
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.userName,
    this.nationalityId,
    this.city,
    this.status,
    this.countryId,
  });

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) => EditProfileRequest(
    photo: json["photo"],
    dob: json["dob"],
    gender: json["gender"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    mobileNo: json["mobile_no"],
    userName: json["user_name"],
    nationalityId: json["nationality_id"],
    city: json["city"],
    status: json["status"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
    "dob": dob,
    "gender": gender,
    "first_name": firstName,
    "last_name": lastName,
    "mobile_no": mobileNo,
    "user_name": userName,
    "nationality_id": nationalityId,
    "city": city,
    "status": status,
    "country_id": countryId,
  };
}