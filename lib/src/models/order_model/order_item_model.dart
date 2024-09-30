
import 'dart:convert';
class OrderItemModel {
  final String orderId;
  final String title;
  final double rating;
  final String time;
  OrderItemModel(this.orderId, this.title, this.rating, this.time, );
}

// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);


OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    String? message;
    bool? success;
    List<Datum>? data;

    OrderModel({
        this.message,
        this.success,
        this.data,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? name;
    int? userId;
    String? address;
    String? city;
    String? state;
    String? postalCode;
    String? phone;
    String? type;
    String? country;
    int? isDefault;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.name,
        this.userId,
        this.address,
        this.city,
        this.state,
        this.postalCode,
        this.phone,
        this.type,
        this.country,
        this.isDefault,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        userId: json["user_id"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postal_code"],
        phone: json["phone"],
        type: json["type"],
        country: json["country"],
        isDefault: json["is_default"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": userId,
        "address": address,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "phone": phone,
        "type": type,
        "country": country,
        "is_default": isDefault,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
