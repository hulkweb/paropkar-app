// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesListModel categoriesModelFromJson(String str) => CategoriesListModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesListModel data) => json.encode(data.toJson());

class CategoriesListModel {
    String? message;
    List<Category>? categories;

    CategoriesListModel({
        this.message,
        this.categories,
    });

    factory CategoriesListModel.fromJson(Map<String, dynamic> json) => CategoriesListModel(
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
    String? name;
    String? image;
    String? description;
    int? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    Category({
        this.id,
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
        "name": name,
        "image": image,
        "description": description,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
