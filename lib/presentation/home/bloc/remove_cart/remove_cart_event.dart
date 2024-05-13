part of 'remove_cart_bloc.dart';

@freezed
class RemoveCartEvent with _$RemoveCartEvent {
  const factory RemoveCartEvent.started() = _Started;
  const factory RemoveCartEvent.removeFromCart(int cartId) = _RemoveFromCart;
}