// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
    String? status;
    List<Datum>? data;

    ProductListModel({
        this.status,
        this.data,
    });

    factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
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
    Category? category;
    Category? subcategory;

    Datum({
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
        this.category,
        this.subcategory,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        subcategory: json["subcategory"] == null ? null : Category.fromJson(json["subcategory"]),
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
        "category": category?.toJson(),
        "subcategory": subcategory?.toJson(),
    };
}

class Category {
    int? id;
    String? name;
    String? image;
    String? description;
    int? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? categoryId;

    Category({
        this.id,
        this.name,
        this.image,
        this.description,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        categoryId: json["category_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category_id": categoryId,
    };
}
