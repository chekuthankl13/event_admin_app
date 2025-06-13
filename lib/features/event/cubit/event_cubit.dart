import 'package:event_admin/core/usecase/usecase.dart';
import 'package:event_admin/features/event/data/model/event_entity_model.dart';
import 'package:event_admin/features/event/domain/entity/event_entity.dart';
import 'package:event_admin/features/event/domain/usecase/create_event_usecase.dart';
import 'package:event_admin/features/event/domain/usecase/delete_event_usecase.dart';
import 'package:event_admin/features/event/domain/usecase/load_event_usecase.dart';
import 'package:event_admin/features/event/domain/usecase/update_event_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_state.dart';
part 'event_cubit.freezed.dart';

class EventCubit extends Cubit<EventState> {
  final LoadEventUsecase loadEventUsecase;
  final DeleteEventUsecase deleteEventUsecase;
  final CreateEventUsecase createEventUsecase;
  final UpdateEventUsecase updateEventUsecase;
  EventCubit(
    this.loadEventUsecase,
    this.deleteEventUsecase,
    this.createEventUsecase, this.updateEventUsecase,
  ) : super(EventState.initial());

  load() async {
    try {
      emit(EventState.loading());
      var res = await loadEventUsecase(NoParam());
      res.fold(
        (l) => emit(EventState.error(error: l.error)),
        (r) => emit(EventState.loaded(events: r)),
      );
    } catch (e) {
      emit(EventState.error(error: e.toString()));
    }
  }

  Future<Map<String, dynamic>> delete(id) async {
    try {
      var res = await deleteEventUsecase(id);
      return res.fold(
        (l) => {"status": "!ok", "message": l.error},
        (r) => {"status": "ok"},
      );
    } catch (e) {
      return {"status": "!ok", "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> create({
    title,
    date,
    location,
    description,
  }) async {
    try {
      var res = await createEventUsecase(
        EventEntityModel(
          id: '',
          title: title,
          date: date,
          location: location,
          description: description,
        ),
      );
      return res.fold(
        (l) => {"status": "!ok", "message": l.error},
        (r) => {"status": "ok"},
      );
    } catch (e) {
      return {"status": "!ok", "message": e.toString()};
    }
  }

   Future<Map<String, dynamic>> update({
    id,
    title,
    date,
    location,
    description,
  }) async {
    try {
      var res = await updateEventUsecase(
        EventEntityModel(
          id: id,
          title: title,
          date: date,
          location: location,
          description: description,
        ),
      );
      return res.fold(
        (l) => {"status": "!ok", "message": l.error},
        (r) => {"status": "ok"},
      );
    } catch (e) {
      return {"status": "!ok", "message": e.toString()};
    }
  }
}
