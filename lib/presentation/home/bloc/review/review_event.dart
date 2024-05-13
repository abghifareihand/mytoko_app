part of 'review_bloc.dart';

@freezed
class ReviewEvent with _$ReviewEvent {
  const factory ReviewEvent.started() = _Started;
  const factory ReviewEvent.addReview(ReviewRequestModel reviewRequest) = _AddReview;
}