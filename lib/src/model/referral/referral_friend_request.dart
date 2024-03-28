import 'dart:convert';

ReferralFriendRequest referralFriendRequestFromJson(String str) => ReferralFriendRequest.fromJson(json.decode(str));

String referralFriendRequestToJson(ReferralFriendRequest data) => json.encode(data.toJson());

class ReferralFriendRequest {
  String referralId;
  String name;
  String email;

  ReferralFriendRequest({
    required this.referralId,
    required this.name,
    required this.email,
  });

  factory ReferralFriendRequest.fromJson(Map<String, dynamic> json) => ReferralFriendRequest(
    referralId: json["referral_id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "referral_id": referralId,
    "name": name,
    "email": email,
  };
}
