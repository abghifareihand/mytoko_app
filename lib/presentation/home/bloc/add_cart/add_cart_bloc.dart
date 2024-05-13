import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mytoko_app/data/datasources/cart_remote_datasource.dart';
import 'package:mytoko_app/data/models/request/add_cart_request_model.dart';
import 'package:mytoko_app/data/models/response/add_cart_response_model.dart';

part 'add_cart_event.dart';
part 'add_cart_state.dart';
part 'add_cart_bloc.freezed.dart';

class AddCartBloc extends Bloc<AddCartEvent, AddCartState> {
  AddCartBloc() : super(const _Initial()) {
    on<_AddToCart>((event, emit) async {
      emit(const _Loading());
      final result =
          await CartRemoteDatasource().addToCart(event.addCartRequest);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
