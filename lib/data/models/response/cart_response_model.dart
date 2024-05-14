import 'dart:convert';

class CartResponseModel {
    final int? code;
    final bool? success;
    final String? message;
    final List<Cart>? data;
    final int? totalQuantity;
    final int? totalPrice;

    CartResponseModel({
        this.code,
        this.success,
        this.message,
        this.data,
        this.totalQuantity,
        this.totalPrice,
    });

    factory CartResponseModel.fromJson(String str) => CartResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CartResponseModel.fromMap(Map<String, dynamic> json) => CartResponseModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Cart>.from(json["data"]!.map((x) => Cart.fromMap(x))),
        totalQuantity: json["total_quantity"],
        totalPrice: json["total_price"],
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "total_quantity": totalQuantity,
        "total_price": totalPrice,
    };
}

class Cart {
    final int? id;
    final int? userId;
    final int? productId;
    final int? quantity;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Product? product;

    Cart({
        this.id,
        this.userId,
        this.productId,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.product,
    });

    factory Cart.fromJson(String str) => Cart.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Cart.fromMap(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        product: json["product"] == null ? null : Product.fromMap(json["product"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toMap(),
    };
}

class Product {
    final int? id;
    final int? categoryId;
    final String? name;
    final String? description;
    final int? price;
    final int? stock;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<Gallery>? galleries;

    Product({
        this.id,
        this.categoryId,
        this.name,
        this.description,
        this.price,
        this.stock,
        this.createdAt,
        this.updatedAt,
        this.galleries,
    });

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        galleries: json["galleries"] == null ? [] : List<Gallery>.from(json["galleries"]!.map((x) => Gallery.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "galleries": galleries == null ? [] : List<dynamic>.from(galleries!.map((x) => x.toMap())),
    };
}

class Gallery {
    final int? id;
    final int? productId;
    final String? imageUrl;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Gallery({
        this.id,
        this.productId,
        this.imageUrl,
        this.createdAt,
        this.updatedAt,
    });

    factory Gallery.fromJson(String str) => Gallery.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Gallery.fromMap(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        productId: json["product_id"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "product_id": productId,
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
