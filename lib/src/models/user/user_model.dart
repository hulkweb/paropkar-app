// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
    String? message;
    bool? success;
    Data? data;

    UserDataModel({
        this.message,
        this.success,
        this.data,
    });

    factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? name;
    String? email;
    String? countryCode;
    dynamic phone;
    dynamic status;
    String? mobile;
    dynamic fcmToken;
    dynamic emailVerifiedAt;
    String? password;
    dynamic rememberToken;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? otp;
    String? type;
    dynamic address;
    dynamic image;
    int? roleId;

    Data({
        this.id,
        this.name,
        this.email,
        this.countryCode,
        this.phone,
        this.status,
        this.mobile,
        this.fcmToken,
        this.emailVerifiedAt,
        this.password,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.otp,
        this.type,
        this.address,
        this.image,
        this.roleId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        countryCode: json["country_code"],
        phone: json["phone"],
        status: json["status"],
        mobile: json["mobile"],
        fcmToken: json["fcm_token"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        otp: json["otp"],
        type: json["type"],
        address: json["address"],
        image: json["image"],
        roleId: json["role_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "country_code": countryCode,
        "phone": phone,
        "status": status,
        "mobile": mobile,
        "fcm_token": fcmToken,
        "email_verified_at": emailVerifiedAt,
        "password": password,
        "remember_token": rememberToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "otp": otp,
        "type": type,
        "address": address,
        "image": image,
        "role_id": roleId,
    };
}
