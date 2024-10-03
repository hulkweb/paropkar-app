// To parse this JSON data, do
//
//     final cartSummaryModel = cartSummaryModelFromJson(jsonString);

import 'dart:convert';

CartSummaryModel cartSummaryModelFromJson(String str) => CartSummaryModel.fromJson(json.decode(str));

String cartSummaryModelToJson(CartSummaryModel data) => json.encode(data.toJson());

class CartSummaryModel {
    String? message;
    bool? success;
    Data? data;

    CartSummaryModel({
        this.message,
        this.success,
        this.data,
    });

    factory CartSummaryModel.fromJson(Map<String, dynamic> json) => CartSummaryModel(
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
    int? subtotal;
    int? total;
    int? tax;

    Data({
        this.subtotal,
        this.total,
        this.tax,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        subtotal: json["subtotal"],
        total: json["total"],
        tax: json["tax"],
    );

    Map<String, dynamic> toJson() => {
        "subtotal": subtotal,
        "total": total,
        "tax": tax,
    };
}
