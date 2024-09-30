// To parse this JSON data, do
//
//     final userPrefModel = userPrefModelFromJson(jsonString);

import 'dart:convert';

UserPrefModel userPrefModelFromJson(String str) => UserPrefModel.fromJson(json.decode(str));

String userPrefModelToJson(UserPrefModel data) => json.encode(data.toJson());

class UserPrefModel {
    String? message;
    bool? success;
    Data? data;

    UserPrefModel({
        this.message,
        this.success,
        this.data,
    });

    factory UserPrefModel.fromJson(Map<String, dynamic> json) => UserPrefModel(
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
    dynamic countryCode;
    dynamic phone;
    dynamic status;
    String? mobile;
    dynamic emailVerifiedAt;
    String? password;
    dynamic rememberToken;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic otp;
    String? token;

    Data({
        this.id,
        this.name,
        this.email,
        this.countryCode,
        this.phone,
        this.status,
        this.mobile,
        this.emailVerifiedAt,
        this.password,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.otp,
        this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        countryCode: json["country_code"],
        phone: json["phone"],
        status: json["status"],
        mobile: json["mobile"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        otp: json["otp"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "country_code": countryCode,
        "phone": phone,
        "status": status,
        "mobile": mobile,
        "email_verified_at": emailVerifiedAt,
        "password": password,
        "remember_token": rememberToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "otp": otp,
        "token": token,
    };
}
