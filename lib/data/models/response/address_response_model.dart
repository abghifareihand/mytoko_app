import 'dart:convert';

class AddressResponseModel {
    final int? code;
    final bool? success;
    final String? message;
    final Data? data;

    AddressResponseModel({
        this.code,
        this.success,
        this.message,
        this.data,
    });

    factory AddressResponseModel.fromJson(String str) => AddressResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddressResponseModel.fromMap(Map<String, dynamic> json) => AddressResponseModel(
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
    final String? name;
    final String? phone;
    final String? fullAddress;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    Data({
        this.userId,
        this.name,
        this.phone,
        this.fullAddress,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        fullAddress: json["full_address"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "user_id": userId,
        "name": name,
        "phone": phone,
        "full_address": fullAddress,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
