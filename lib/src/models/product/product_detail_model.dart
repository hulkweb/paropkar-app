// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

ProductDetailModel productDetailModelFromJson(String str) => ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) => json.encode(data.toJson());

class ProductDetailModel {
    String? message;
    Data? data;
    bool? success;

    ProductDetailModel({
        this.message,
        this.data,
        this.success,
    });

    factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "success": success,
    };
}

class Data {
    Product? product;
    List<RelatedProduct>? relatedProducts;

    Data({
        this.product,
        this.relatedProducts,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        relatedProducts: json["related_products"] == null ? [] : List<RelatedProduct>.from(json["related_products"]!.map((x) => RelatedProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "related_products": relatedProducts == null ? [] : List<dynamic>.from(relatedProducts!.map((x) => x.toJson())),
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
    List<String>? multiImage;
    String? productType;
    String? description;
    int? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? isCart;
    bool? isFavorite;
    List<Variation>? variations;

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
        this.isCart,
        this.isFavorite,
        this.variations,
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
        multiImage: json["multi_image"] == null ? [] : List<String>.from(json["multi_image"]!.map((x) => x)),
        productType: json["product_type"],
        description: json["description"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isCart: json["isCart"],
        isFavorite: json["isFavorite"],
        variations: json["variations"] == null ? [] : List<Variation>.from(json["variations"]!.map((x) => Variation.fromJson(x))),
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
        "multi_image": multiImage == null ? [] : List<dynamic>.from(multiImage!.map((x) => x)),
        "product_type": productType,
        "description": description,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "isCart": isCart,
        "isFavorite": isFavorite,
        "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x.toJson())),
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

class RelatedProduct {
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
    bool? isCart;
    bool? isFavorite;
    List<Variation>? variations;

    RelatedProduct({
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
        this.isCart,
        this.isFavorite,
        this.variations,
    });

    factory RelatedProduct.fromJson(Map<String, dynamic> json) => RelatedProduct(
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
        isCart: json["isCart"],
        isFavorite: json["isFavorite"],
        variations: json["variations"] == null ? [] : List<Variation>.from(json["variations"]!.map((x) => Variation.fromJson(x))),
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
        "isCart": isCart,
        "isFavorite": isFavorite,
        "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x.toJson())),
    };
}
