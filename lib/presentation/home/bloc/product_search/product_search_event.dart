part of 'product_search_bloc.dart';

@freezed
class ProductSearchEvent with _$ProductSearchEvent {
  const factory ProductSearchEvent.started() = _Started;
  const factory ProductSearchEvent.getProductSearch(String productName) = _GetProductSearch;
}
