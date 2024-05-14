import 'dart:convert';

class RemoveCartResponseModel {
    final int? code;
    final bool? success;
    final String? message;
    final Data? data;

    RemoveCartResponseModel({
        this.code,
        this.success,
        this.message,
        this.data,
    });

    factory RemoveCartResponseModel.fromJson(String str) => RemoveCartResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RemoveCartResponseModel.fromMap(Map<String, dynamic> json) => RemoveCartResponseModel(
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
    final int? id;
    final int? userId;
    final int? productId;
    final int? quantity;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Data({
        this.id,
        this.userId,
        this.productId,
        this.quantity,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
