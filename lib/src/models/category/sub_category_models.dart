// To parse this JSON data, do
//
//     final subCategoriesListModel = subCategoriesListModelFromJson(jsonString);

import 'dart:convert';

SubCategoriesListModel subCategoriesListModelFromJson(String str) => SubCategoriesListModel.fromJson(json.decode(str));

String subCategoriesListModelToJson(SubCategoriesListModel data) => json.encode(data.toJson());

class SubCategoriesListModel {
    String? message;
    List<Datum>? data;
    bool? success;

    SubCategoriesListModel({
        this.message,
        this.data,
        this.success,
    });

    factory SubCategoriesListModel.fromJson(Map<String, dynamic> json) => SubCategoriesListModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
    };
}

class Datum {
    int? id;
    int? categoryId;
    String? name;
    String? image;
    String? description;
    int? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
