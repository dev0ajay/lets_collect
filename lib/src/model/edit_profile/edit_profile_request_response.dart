// To parse this JSON data, do
//
//     final editProfileRequestResponse = editProfileRequestResponseFromJson(jsonString);

import 'dart:convert';

EditProfileRequestResponse editProfileRequestResponseFromJson(String str) => EditProfileRequestResponse.fromJson(json.decode(str));

String editProfileRequestResponseToJson(EditProfileRequestResponse data) => json.encode(data.toJson());

class EditProfileRequestResponse {
  bool? status;
  bool? data;
  String? message;

  EditProfileRequestResponse({
    this.status,
    this.data,
    this.message,
  });

  factory EditProfileRequestResponse.fromJson(Map<String, dynamic> json) => EditProfileRequestResponse(
    status: json["status"],
    data: json["data"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
    "message": message,
  };
}


// import 'dart:convert';
//
// EditProfileRequestResponse editProfileRequestResponseFromJson(String str) =>
//     EditProfileRequestResponse.fromJson(json.decode(str));
//
// String editProfileRequestResponseToJson(EditProfileRequestResponse data) =>
//     json.encode(data.toJson());
//
// class EditProfileRequestResponse {
//   bool? success;
//   dynamic data; // Adjusted data type to dynamic
//   String? message;
//
//   EditProfileRequestResponse({
//     this.success,
//     this.data,
//     this.message,
//   });
//
//   factory EditProfileRequestResponse.fromJson(Map<String, dynamic> json) =>
//       EditProfileRequestResponse(
//         success: json["success"],
//         data: json["data"],
//         message: json["message"],
//       );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "data": data,
//     "message": message,
//   };
// }