import 'dart:convert';

class FavoriteRequestModel {
    final int productId;

    FavoriteRequestModel({
        required this.productId,
    });

    factory FavoriteRequestModel.fromJson(String str) => FavoriteRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FavoriteRequestModel.fromMap(Map<String, dynamic> json) => FavoriteRequestModel(
        productId: json["product_id"],
    );

    Map<String, dynamic> toMap() => {
        "product_id": productId,
    };
}
