part of 'add_cart_bloc.dart';

@freezed
class AddCartState with _$AddCartState {
  const factory AddCartState.initial() = _Initial;
  const factory AddCartState.loading() = _Loading;
  const factory AddCartState.loaded(AddCartResponseModel addCartResponse) =
      _Loaded;
  const factory AddCartState.error(String message) = _Error;
}
