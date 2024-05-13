import 'dart:convert';

class ReviewResponseModel {
    final int? code;
    final bool? success;
    final String? message;
    final Data? data;

    ReviewResponseModel({
        this.code,
        this.success,
        this.message,
        this.data,
    });

    factory ReviewResponseModel.fromJson(String str) => ReviewResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ReviewResponseModel.fromMap(Map<String, dynamic> json) => ReviewResponseModel(
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
    final double? rating;
    final String? comment;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    Data({
        this.userId,
        this.productId,
        this.rating,
        this.comment,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        productId: json["product_id"],
        rating: json["rating"]?.toDouble(),
        comment: json["comment"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "user_id": userId,
        "product_id": productId,
        "rating": rating,
        "comment": comment,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
