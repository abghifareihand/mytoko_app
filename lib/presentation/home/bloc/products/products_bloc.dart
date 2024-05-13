import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/product_remote_datasource.dart';
import '../../../../data/models/response/products_response_model.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final int limit = 10;
  int page = 1;
  bool hasMore = true;
  List<Product> products = [];

  ProductsBloc() : super(const _Initial()) {
    on<_GetProducts>((event, emit) async {
      final result = await ProductRemoteDatasource().getProducts();
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data.data!.data!)),
      );
    });
    // on<_GetProducts>((event, emit) async {
    //   final result = await ProductRemoteDatasource().getProductsPaginate(page, limit);
    //   result.fold(
    //     (error) => emit(_Error(error)),
    //     (data) {
    //       debugPrint('Get User: ${data.data!.data!.length}');
    //       debugPrint('Page: $page');
    //       hasMore = data.data!.data!.length < limit ? false : true;
    //       products.addAll(data.data!.data!);
    //       page++;
    //       debugPrint('Total Users: ${products.length}');
    //       emit(_Loaded(products));
    //     },
    //   );
    // });
  }
}
