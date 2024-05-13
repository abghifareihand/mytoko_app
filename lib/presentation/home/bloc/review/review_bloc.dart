import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mytoko_app/data/datasources/review_remote_datasource.dart';
import 'package:mytoko_app/data/models/request/review_request_model.dart';
import 'package:mytoko_app/data/models/response/review_response_model.dart';

part 'review_event.dart';
part 'review_state.dart';
part 'review_bloc.freezed.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(const _Initial()) {
    on<_AddReview>((event, emit) async {
      emit(const _Loading());
      final result = await ReviewRemoteDatasource().addReviewProduct(event.reviewRequest);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
