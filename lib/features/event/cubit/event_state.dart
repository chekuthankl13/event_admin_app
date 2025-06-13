part of 'event_cubit.dart';

@freezed
sealed class EventState with _$EventState {
  const EventState._();
  const factory EventState.initial() = Initial;
  const factory EventState.loading() = Loading;
  const factory EventState.error({required String error}) = Error;
  const factory EventState.loaded({required List<EventEntity> events}) = Loaded;
}
