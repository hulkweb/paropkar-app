// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) => OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) => json.encode(data.toJson());

class OrderDetailModel {
    String? message;
    bool? success;
    Data? data;

    OrderDetailModel({
        this.message,
        this.success,
        this.data,
    });

    factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
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
    int? userId;
    String? orderNumber;
    String? totalAmount;
    String? status;
    dynamic transactionId;
    String? tax;
    String? paymentStatus;
    String? paymentType;
    String? shippingAddress;
    dynamic orderedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic address;
    List<OrderItem>? orderItems;
    User? user;

    Data({
        this.id,
        this.userId,
        this.orderNumber,
        this.totalAmount,
        this.status,
        this.transactionId,
        this.tax,
        this.paymentStatus,
        this.paymentType,
        this.shippingAddress,
        this.orderedAt,
        this.createdAt,
        this.updatedAt,
        this.address,
        this.orderItems,
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        orderNumber: json["order_number"],
        totalAmount: json["total_amount"],
        status: json["status"],
        transactionId: json["transaction_id"],
        tax: json["tax"],
        paymentStatus: json["payment_status"],
        paymentType: json["payment_type"],
        shippingAddress: json["shipping_address"],
        orderedAt: json["ordered_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        address: json["address"],
        orderItems: json["order_items"] == null ? [] : List<OrderItem>.from(json["order_items"]!.map((x) => OrderItem.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_number": orderNumber,
        "total_amount": totalAmount,
        "status": status,
        "transaction_id": transactionId,
        "tax": tax,
        "payment_status": paymentStatus,
        "payment_type": paymentType,
        "shipping_address": shippingAddress,
        "ordered_at": orderedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "address": address,
        "order_items": orderItems == null ? [] : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "user": user?.toJson(),
    };
}

class OrderItem {
    int? id;
    int? orderId;
    int? productId;
    int? quantity;
    String? price;
    String? totalAmount;
    String? variationId;
    DateTime? createdAt;
    DateTime? updatedAt;
    Product? product;
    Variation? variation;

    OrderItem({
        this.id,
        this.orderId,
        this.productId,
        this.quantity,
        this.price,
        this.totalAmount,
        this.variationId,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.variation,
    });

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
        totalAmount: json["total_amount"],
        variationId: json["variation_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        variation: json["variation"] == null ? null : Variation.fromJson(json["variation"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "total_amount": totalAmount,
        "variation_id": variationId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
        "variation": variation?.toJson(),
    };
}

class Product {
    int? id;
    String? name;
    int? categoryId;
    int? subcategoryId;
    String? price;
    int? stock;
    String? discountType;
    String? discountValue;
    String? image;
    String? productType;
    String? description;
    int? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    Product({
        this.id,
        this.name,
        this.categoryId,
        this.subcategoryId,
        this.price,
        this.stock,
        this.discountType,
        this.discountValue,
        this.image,
        this.productType,
        this.description,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        price: json["price"],
        stock: json["stock"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        image: json["image"],
        productType: json["product_type"],
        description: json["description"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "price": price,
        "stock": stock,
        "discount_type": discountType,
        "discount_value": discountValue,
        "image": image,
        "product_type": productType,
        "description": description,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Variation {
    int? id;
    int? productId;
    String? variationName;
    String? color;
    String? size;
    String? price;
    int? stock;
    dynamic image;
    int? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    Variation({
        this.id,
        this.productId,
        this.variationName,
        this.color,
        this.size,
        this.price,
        this.stock,
        this.image,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        id: json["id"],
        productId: json["product_id"],
        variationName: json["variation_name"],
        color: json["color"],
        size: json["size"],
        price: json["price"],
        stock: json["stock"],
        image: json["image"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "variation_name": variationName,
        "color": color,
        "size": size,
        "price": price,
        "stock": stock,
        "image": image,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class User {
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

    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
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
