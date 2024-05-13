import 'dart:convert';

class ResgisterRequestModel {
    final String name;
    final String email;
    final String password;
    final String phone;

    ResgisterRequestModel({
        required this.name,
        required this.email,
        required this.password,
        required this.phone,
    });

    factory ResgisterRequestModel.fromJson(String str) => ResgisterRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ResgisterRequestModel.fromMap(Map<String, dynamic> json) => ResgisterRequestModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
    };
}
