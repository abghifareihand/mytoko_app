import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mytoko_app/data/datasources/product_remote_datasource.dart';
import 'package:mytoko_app/data/models/response/products_response_model.dart';

part 'product_search_event.dart';
part 'product_search_state.dart';
part 'product_search_bloc.freezed.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  ProductSearchBloc() : super(const _Initial()) {
    on<_GetProductSearch>((event, emit) async {
      emit(const _Loading());
      final result =
          await ProductRemoteDatasource().getProductByName(event.productName);
      result.fold(
        (error) => emit(_Error(error)),
        (data) {
        
          emit(_Loaded(data.data!.data!));
        },
      );
    });

    on<_Started>((event, emit) async {
      emit(const _Initial());
    });
  }
}
