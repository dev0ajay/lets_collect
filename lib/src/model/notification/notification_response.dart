

import 'dart:convert';

NotificationGetResponse notificationResponseFromJson(String str) => NotificationGetResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationGetResponse data) => json.encode(data.toJson());

class NotificationGetResponse {
  bool? success;
  int? statusCode;
  List<Datum>? data;

  NotificationGetResponse({
    this.success,
    this.statusCode,
    this.data,
  });

  factory NotificationGetResponse.fromJson(Map<String, dynamic> json) => NotificationGetResponse(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? notificationTitle;
  String? notificationMessage;
  String? addedDate;

  Datum({
    this.id,
    this.notificationTitle,
    this.notificationMessage,
    this.addedDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    notificationTitle: json["notification_title"],
    notificationMessage: json["notification_message"],
    addedDate: json["added_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "notification_title": notificationTitle,
    "notification_message": notificationMessage,
    "added_date": addedDate,
  };
}
