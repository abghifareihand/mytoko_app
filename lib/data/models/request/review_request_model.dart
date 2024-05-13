import 'dart:convert';

class ReviewRequestModel {
    final int productId;
    final String comment;
    final double rating;

    ReviewRequestModel({
        required this.productId,
        required this.comment,
        required this.rating,
    });

    factory ReviewRequestModel.fromJson(String str) => ReviewRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ReviewRequestModel.fromMap(Map<String, dynamic> json) => ReviewRequestModel(
        productId: json["product_id"],
        comment: json["comment"],
        rating: json["rating"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "product_id": productId,
        "comment": comment,
        "rating": rating,
    };
}
