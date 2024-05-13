import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mytoko_app/data/datasources/product_remote_datasource.dart';
import 'package:mytoko_app/data/models/response/product_detail_response_model.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';
part 'product_detail_bloc.freezed.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(const _Initial()) {
    on<_GetProductDetail>((event, emit) async {
      emit(const _Loading());
      final result =
          await ProductRemoteDatasource().getProductById(event.productId);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
