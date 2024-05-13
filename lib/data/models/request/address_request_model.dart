import 'dart:convert';

class AddressRequestModel {
    final String name;
    final String phone;
    final String fullAddress;

    AddressRequestModel({
        required this.name,
        required this.phone,
        required this.fullAddress,
    });

    factory AddressRequestModel.fromJson(String str) => AddressRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddressRequestModel.fromMap(Map<String, dynamic> json) => AddressRequestModel(
        name: json["name"],
        phone: json["phone"],
        fullAddress: json["full_address"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "phone": phone,
        "full_address": fullAddress,
    };
}
