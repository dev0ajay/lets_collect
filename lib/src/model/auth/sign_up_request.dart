import 'dart:convert';

SignupRequest signupRequestFromJson(String str) => SignupRequest.fromJson(json.decode(str));

String signupRequestToJson(SignupRequest data) => json.encode(data.toJson());

class SignupRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNo;
  final String userName;
  final String password;
  final String gender;
  final String dob;
  final String nationalityId;
  final String city;
  final String countryId;

  SignupRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNo,
    required this.userName,
    required this.password,
    required this.gender,
    required this.dob,
    required this.nationalityId,
    required this.city,
    required this.countryId,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) => SignupRequest(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    mobileNo: json["mobile_no"],
    userName: json["user_name"],
    password: json["password"],
    gender: json["gender"],
    dob: json["dob"],
    nationalityId: json["nationality_id"],
    city: json["city"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "mobile_no": mobileNo,
    "user_name": userName,
    "password": password,
    "gender": gender,
    "dob": dob,
    "nationality_id": nationalityId,
    "city": city,
    "country_id": countryId,
  };
}
