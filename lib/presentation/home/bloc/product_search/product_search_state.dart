part of 'product_search_bloc.dart';

@freezed
class ProductSearchState with _$ProductSearchState {
  const factory ProductSearchState.initial() = _Initial;
  const factory ProductSearchState.loading() = _Loading;
  const factory ProductSearchState.loaded(
      List<Product> productResponse) = _Loaded;
  const factory ProductSearchState.error(String message) = _Error;
}
