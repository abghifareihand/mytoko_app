import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mytoko_app/data/models/request/review_request_model.dart';
import 'package:mytoko_app/data/models/response/review_response_model.dart';

import '../../core/constants/variables.dart';
import 'auth_local_datasource.dart';

class ReviewRemoteDatasource {
  Future<Either<String, ReviewResponseModel>> addReviewProduct(
      ReviewRequestModel reviewRequest) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/reviews'),
      headers: headers,
      body: reviewRequest.toJson(),
    );

    log('Response Add Review : ${response.body}');

    if (response.statusCode == 201) {
      return Right(ReviewResponseModel.fromJson(response.body));
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return Left(errorMessage);
    }
  }
}
