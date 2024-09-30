// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
    String? message;
    Data? data;
    bool? success;

    ProductListModel({
        this.message,
        this.data,
        this.success,
    });

    factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
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
    int? currentPage;
    List<Datum>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    Data({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
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
    bool? isCart;
    bool? isFavorite;
    List<Variation>? variations;
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
        this.isCart,
        this.isFavorite,
        this.variations,
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
        isCart: json["isCart"],
        isFavorite: json["isFavorite"],
        variations: json["variations"] == null ? [] : List<Variation>.from(json["variations"]!.map((x) => Variation.fromJson(x))),
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
        "isCart": isCart,
        "isFavorite": isFavorite,
        "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x.toJson())),
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

class Variation {
    int? id;
    int? productId;
    String? variationName;
    String? color;
    String? size;
    String? price;
    int? stock;
    String? image;
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

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
