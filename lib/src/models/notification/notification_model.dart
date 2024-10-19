// To parse this JSON data, do
//
//     final notifitionModel = notifitionModelFromJson(jsonString);

import 'dart:convert';

NotifitionModel notifitionModelFromJson(String str) => NotifitionModel.fromJson(json.decode(str));

String notifitionModelToJson(NotifitionModel data) => json.encode(data.toJson());

class NotifitionModel {
    dynamic message;
    bool? success;
    NotifitionModelData? data;

    NotifitionModel({
        this.message,
        this.success,
        this.data,
    });

    factory NotifitionModel.fromJson(Map<String, dynamic> json) => NotifitionModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : NotifitionModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data?.toJson(),
    };
}

class NotifitionModelData {
    List<Notification>? notifications;
    int? unread;

    NotifitionModelData({
        this.notifications,
        this.unread,
    });

    factory NotifitionModelData.fromJson(Map<String, dynamic> json) => NotifitionModelData(
        notifications: json["notifications"] == null ? [] : List<Notification>.from(json["notifications"]!.map((x) => Notification.fromJson(x))),
        unread: json["unread"],
    );

    Map<String, dynamic> toJson() => {
        "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "unread": unread,
    };
}

class Notification {
    int? id;
    String? title;
    String? message;
    String? image;
    String? type;
    int? userId;
    int? read;
    NotificationData? data;
    DateTime? createdAt;
    DateTime? updatedAt;

    Notification({
        this.id,
        this.title,
        this.message,
        this.image,
        this.type,
        this.userId,
        this.read,
        this.data,
        this.createdAt,
        this.updatedAt,
    });

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        image: json["image"],
        type: json["type"],
        userId: json["user_id"],
        read: json["read"],
        data: json["data"] == null ? null : NotificationData.fromJson(json["data"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "message": message,
        "image": image,
        "type": type,
        "user_id": userId,
        "read": read,
        "data": data?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class NotificationData {
    String? typeId;
    String? type;
    DateTime? dateTime;

    NotificationData({
        this.typeId,
        this.type,
        this.dateTime,
    });

    factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        typeId: json["type_id"],
        type: json["type"],
        dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
    );

    Map<String, dynamic> toJson() => {
        "type_id": typeId,
        "type": type,
        "date_time": dateTime?.toIso8601String(),
    };
}
