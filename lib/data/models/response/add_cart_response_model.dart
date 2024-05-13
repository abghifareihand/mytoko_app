import 'dart:convert';

class AddCartResponseModel {
    final int? code;
    final bool? success;
    final String? message;
    final Data? data;

    AddCartResponseModel({
        this.code,
        this.success,
        this.message,
        this.data,
    });

    factory AddCartResponseModel.fromJson(String str) => AddCartResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddCartResponseModel.fromMap(Map<String, dynamic> json) => AddCartResponseModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "success": success,
        "message": message,
        "data": data?.toMap(),
    };
}

class Data {
    final int? userId;
    final int? productId;
    final int? quantity;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    Data({
        this.userId,
        this.productId,
        this.quantity,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
