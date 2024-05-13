part of 'add_cart_bloc.dart';

@freezed
class AddCartEvent with _$AddCartEvent {
  const factory AddCartEvent.started() = _Started;
   const factory AddCartEvent.addToCart(AddCartRequestModel addCartRequest) = _AddToCart;
}