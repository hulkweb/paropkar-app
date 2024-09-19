// To parse this JSON data, do
//
//     final subCategoriesModel = subCategoriesModelFromJson(jsonString);

import 'dart:convert';

SubCategoriesListModel subCategoriesModelFromJson(String str) => SubCategoriesListModel.fromJson(json.decode(str));

String subCategoriesModelToJson(SubCategoriesListModel data) => json.encode(data.toJson());

class SubCategoriesListModel {
    String? message;
    List<Category>? categories;

    SubCategoriesListModel({
        this.message,
        this.categories,
    });

    factory SubCategoriesListModel.fromJson(Map<String, dynamic> json) => SubCategoriesListModel(
        message: json["message"],
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    };
}

class Category {
    int? id;
    int? categoryId;
    String? name;
    String? image;
    String? description;
    int? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    Category({
        this.id,
        this.categoryId,
        this.name,
        this.image,
        this.description,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "image": image,
        "description": description,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
