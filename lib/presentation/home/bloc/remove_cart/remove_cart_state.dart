part of 'remove_cart_bloc.dart';

@freezed
class RemoveCartState with _$RemoveCartState {
  const factory RemoveCartState.initial() = _Initial;
  const factory RemoveCartState.loading() = _Loading;
  const factory RemoveCartState.loaded(String message) = _Loaded;
  const factory RemoveCartState.error(String message) = _Error;
}
