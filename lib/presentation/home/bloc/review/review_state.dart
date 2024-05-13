part of 'review_bloc.dart';

@freezed
class ReviewState with _$ReviewState {
  const factory ReviewState.initial() = _Initial;
  const factory ReviewState.loading() = _Loading;
  const factory ReviewState.loaded(ReviewResponseModel reviewResponse) = _Loaded;
  const factory ReviewState.error(String message) = _Error;
}
