import 'dart:convert';

class ProductDetailResponseModel {
    final int? code;
    final bool? success;
    final String? message;
    final Data? data;

    ProductDetailResponseModel({
        this.code,
        this.success,
        this.message,
        this.data,
    });

    factory ProductDetailResponseModel.fromJson(String str) => ProductDetailResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductDetailResponseModel.fromMap(Map<String, dynamic> json) => ProductDetailResponseModel(
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
    final int? categoryId;
    final String? name;
    final String? description;
    final int? price;
    final int? stock;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final bool? isFavorite;
    final List<Favorite>? galleries;
    final Category? category;
    final List<Review>? reviews;
    final List<Favorite>? favorites;

    Data({
        this.id,
        this.categoryId,
        this.name,
        this.description,
        this.price,
        this.stock,
        this.createdAt,
        this.updatedAt,
        this.isFavorite,
        this.galleries,
        this.category,
        this.reviews,
        this.favorites,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isFavorite: json["is_favorite"],
        galleries: json["galleries"] == null ? [] : List<Favorite>.from(json["galleries"]!.map((x) => Favorite.fromMap(x))),
        category: json["category"] == null ? null : Category.fromMap(json["category"]),
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromMap(x))),
        favorites: json["favorites"] == null ? [] : List<Favorite>.from(json["favorites"]!.map((x) => Favorite.fromMap(x))),
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
        "is_favorite": isFavorite,
        "galleries": galleries == null ? [] : List<dynamic>.from(galleries!.map((x) => x.toMap())),
        "category": category?.toMap(),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toMap())),
        "favorites": favorites == null ? [] : List<dynamic>.from(favorites!.map((x) => x.toMap())),
    };
}

class Category {
    final int? id;
    final String? name;
    final String? image;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Category({
        this.id,
        this.name,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Favorite {
    final int? id;
    final int? userId;
    final int? productId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? imageUrl;

    Favorite({
        this.id,
        this.userId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.imageUrl,
    });

    factory Favorite.fromJson(String str) => Favorite.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageUrl,
    };
}

class Review {
    final int? id;
    final int? userId;
    final int? productId;
    final String? comment;
    final double? rating;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final User? user;

    Review({
        this.id,
        this.userId,
        this.productId,
        this.comment,
        this.rating,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Review.fromMap(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        comment: json["comment"],
        rating: json["rating"]?.toDouble(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "comment": comment,
        "rating": rating,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toMap(),
    };
}

class User {
    final int? id;
    final String? name;
    final String? email;

    User({
        this.id,
        this.name,
        this.email,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
    };
}
