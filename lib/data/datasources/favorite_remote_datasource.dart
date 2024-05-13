import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mytoko_app/data/models/request/favorite_request_model.dart';
import 'package:mytoko_app/data/models/response/favorite_response_model.dart';

import '../../core/constants/variables.dart';
import 'auth_local_datasource.dart';

class FavoriteRemoteDatasource {
  Future<Either<String, FavoriteResponseModel>> doFavorite(
      FavoriteRequestModel favoriteRequest) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/favorite'),
      headers: headers,
      body: favoriteRequest.toJson(),
    );

    log('Response Add Review : ${response.body}');

    if (response.statusCode == 200) {
      return Right(FavoriteResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }
}
