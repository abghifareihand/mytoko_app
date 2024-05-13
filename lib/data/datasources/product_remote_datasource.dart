import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mytoko_app/data/models/response/product_detail_response_model.dart';

import '../../core/constants/variables.dart';
import '../models/response/products_response_model.dart';
import 'auth_local_datasource.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductsResponseModel>> getProducts() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/products'),
      headers: headers,
    );

    log('Response Get Products : ${response.body}');

    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, ProductsResponseModel>> getProductsPaginate(int page, int limit) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/products?page=$page&limit=$limit'),
      headers: headers,
    );

    log('Response Get Products : ${response.body}');

    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }

  Future<Either<String, ProductDetailResponseModel>> getProductDetail(int productId) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/products/$productId'),
      headers: headers,
    );

    log('Response Get Product Detail : ${response.body}');

    if (response.statusCode == 200) {
      return Right(ProductDetailResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }
}