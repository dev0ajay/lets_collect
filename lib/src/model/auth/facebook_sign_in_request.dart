
import 'dart:convert';

FacebookSignInRequest facebookSignInRequestFromJson(String str) => FacebookSignInRequest.fromJson(json.decode(str));

String facebookSignInRequestToJson(FacebookSignInRequest data) => json.encode(data.toJson());

class FacebookSignInRequest {
  final String email;
  final String displayName;
  final String mobileNo;
  final String faceBookId;
  final String deviceToken;
  final String deviceType;

  FacebookSignInRequest({
    required this.email,
    required this.displayName,
    required this.mobileNo,
    required this.faceBookId,
    required this.deviceToken,
    required this.deviceType,
  });

  factory FacebookSignInRequest.fromJson(Map<String, dynamic> json) => FacebookSignInRequest(
    email: json["email"],
    displayName: json["display_name"],
    mobileNo: json["mobile_no"],
    faceBookId: json["face_book_id"],
    deviceToken: json["device_token"],
    deviceType: json["device_type"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "display_name": displayName,
    "mobile_no": mobileNo,
    "face_book_id": faceBookId,
    "device_token": deviceToken,
    "device_type": deviceType,
  };
}
