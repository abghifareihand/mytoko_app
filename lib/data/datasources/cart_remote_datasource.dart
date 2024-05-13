import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mytoko_app/data/models/request/add_cart_request_model.dart';
import 'package:mytoko_app/data/models/response/add_cart_response_model.dart';
import 'package:mytoko_app/data/models/response/cart_response_model.dart';

import '../../core/constants/variables.dart';
import 'auth_local_datasource.dart';

class CartRemoteDatasource {
  /// ADD TO CART
  Future<Either<String, AddCartResponseModel>> addToCart(
      AddCartRequestModel addCartRequest) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/cart'),
      headers: headers,
      body: addCartRequest.toJson(),
    );

    log('Response Add to Cart : ${response.body}');

    if (response.statusCode == 200) {
      return Right(AddCartResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }

  /// GET DATA CART
  Future<Either<String, CartResponseModel>> getCart() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/cart'),
      headers: headers,
    );

    log('Response Get Cart : ${response.body}');

    if (response.statusCode == 200) {
      return Right(CartResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }

  /// REMOVE FROM CART
  Future<Either<String, String>> removeFromCart(int cartId) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.delete(
      Uri.parse('${Variables.baseUrl}/api/cart/$cartId'),
      headers: headers,
    );

    log('Response Get Cart : ${response.body}');

    if (response.statusCode == 200) {
      final successMessage = jsonDecode(response.body)['message'];
      return Right(successMessage);
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }
}
