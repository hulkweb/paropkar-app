// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    String? message;
    bool? success;
    List<Datum>? data;

    CartModel({
        this.message,
        this.success,
        this.data,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
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
    int? userId;
    int? productId;
    dynamic createBy;
    int? variationId;
    int? quantity;
    DateTime? createdAt;
    DateTime? updatedAt;
    Product? product;
    Variation? variation;

    Datum({
        this.id,
        this.userId,
        this.productId,
        this.createBy,
        this.variationId,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.variation,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        createBy: json["createBy"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        variation: json["variation"] == null ? null : Variation.fromJson(json["variation"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "createBy": createBy,
        "variation_id": variationId,
        "quantity": quantity,
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
    int? popular;
    String? discountType;
    String? discountValue;
    String? image;
    String? multiImage;
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
        this.popular,
        this.discountType,
        this.discountValue,
        this.image,
        this.multiImage,
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
        popular: json["popular"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        image: json["image"],
        multiImage: json["multi_image"],
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
        "popular": popular,
        "discount_type": discountType,
        "discount_value": discountValue,
        "image": image,
        "multi_image": multiImage,
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
    dynamic color;
    dynamic size;
    String? price;
    int? stock;
    String? margin;
    String? toQty;
    String? fromQty;
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
        this.margin,
        this.toQty,
        this.fromQty,
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
        margin: json["margin"],
        toQty: json["to_qty"],
        fromQty: json["from_qty"],
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
        "margin": margin,
        "to_qty": toQty,
        "from_qty": fromQty,
        "image": image,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
