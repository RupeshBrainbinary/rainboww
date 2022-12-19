import 'dart:convert';

NotificationOnOffModel notificationModelFromJson(String str) =>
    NotificationOnOffModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationOnOffModel data) =>
    json.encode(data.toJson());

class NotificationOnOffModel {
  NotificationOnOffModel({
    this.status,
    this.message,
    this.data
  });

  bool? status;
  String? message;
  bool? data;

  factory NotificationOnOffModel.fromJson(Map<String, dynamic> json) =>
      NotificationOnOffModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
