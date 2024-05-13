
import 'dart:convert';

class AddCartRequestModel {
    final int productId;

    AddCartRequestModel({
        required this.productId,
    });

    factory AddCartRequestModel.fromJson(String str) => AddCartRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddCartRequestModel.fromMap(Map<String, dynamic> json) => AddCartRequestModel(
        productId: json["product_id"],
    );

    Map<String, dynamic> toMap() => {
        "product_id": productId,
    };
}
