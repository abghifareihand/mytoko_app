import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mytoko_app/data/datasources/favorite_remote_datasource.dart';
import 'package:mytoko_app/data/models/request/favorite_request_model.dart';
import 'package:mytoko_app/data/models/response/favorite_response_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';
part 'favorite_bloc.freezed.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const _Initial()) {
    on<_DoFavorite>((event, emit) async {
      emit(const _Loading());
      final result =
          await FavoriteRemoteDatasource().doFavorite(event.favoriteRequest);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
