import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mytoko_app/data/datasources/cart_remote_datasource.dart';
import 'package:mytoko_app/data/models/response/remove_cart_response_model.dart';

part 'remove_cart_event.dart';
part 'remove_cart_state.dart';
part 'remove_cart_bloc.freezed.dart';

class RemoveCartBloc extends Bloc<RemoveCartEvent, RemoveCartState> {
  RemoveCartBloc() : super(const _Initial()) {
    on<_RemoveFromCart>((event, emit) async {
     emit(const _Loading());
      final result =
          await CartRemoteDatasource().removeFromCart(event.cartId);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
