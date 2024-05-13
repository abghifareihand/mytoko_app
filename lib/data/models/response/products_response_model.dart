import 'dart:convert';

class ProductsResponseModel {
    final int? code;
    final bool? success;
    final String? message;
    final Data? data;

    ProductsResponseModel({
        this.code,
        this.success,
        this.message,
        this.data,
    });

    factory ProductsResponseModel.fromJson(String str) => ProductsResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductsResponseModel.fromMap(Map<String, dynamic> json) => ProductsResponseModel(
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
    final int? currentPage;
    final List<Product>? data;
    final String? firstPageUrl;
    final int? from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<Link>? links;
    final String? nextPageUrl;
    final String? path;
    final int? perPage;
    final dynamic prevPageUrl;
    final int? to;
    final int? total;

    Data({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Product {
    final int? id;
    final String? name;
    final int? price;
    final int? stock;
    final int? categoryId;
    final int? totalFavorite;
    final bool? isFavorite;
    final Category? category;
    final List<Gallery>? galleries;
    final List<dynamic>? favorites;

    Product({
        this.id,
        this.name,
        this.price,
        this.stock,
        this.categoryId,
        this.totalFavorite,
        this.isFavorite,
        this.category,
        this.galleries,
        this.favorites,
    });

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        stock: json["stock"],
        categoryId: json["category_id"],
        totalFavorite: json["total_favorite"],
        isFavorite: json["is_favorite"],
        category: json["category"] == null ? null : Category.fromMap(json["category"]),
        galleries: json["galleries"] == null ? [] : List<Gallery>.from(json["galleries"]!.map((x) => Gallery.fromMap(x))),
        favorites: json["favorites"] == null ? [] : List<dynamic>.from(json["favorites"]!.map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "stock": stock,
        "category_id": categoryId,
        "total_favorite": totalFavorite,
        "is_favorite": isFavorite,
        "category": category?.toMap(),
        "galleries": galleries == null ? [] : List<dynamic>.from(galleries!.map((x) => x.toMap())),
        "favorites": favorites == null ? [] : List<dynamic>.from(favorites!.map((x) => x)),
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

class Link {
    final String? url;
    final String? label;
    final bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
