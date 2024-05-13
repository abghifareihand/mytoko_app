import 'dart:convert';

class FavoriteResponseModel {
    final int? productId;
    final bool? isFavorite;
    final String? message;

    FavoriteResponseModel({
        this.productId,
        this.isFavorite,
        this.message,
    });

    factory FavoriteResponseModel.fromJson(String str) => FavoriteResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FavoriteResponseModel.fromMap(Map<String, dynamic> json) => FavoriteResponseModel(
        productId: json["product_id"],
        isFavorite: json["is_favorite"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "product_id": productId,
        "is_favorite": isFavorite,
        "message": message,
    };
}
