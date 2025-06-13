import 'package:dartz/dartz.dart';
import 'package:event_admin/core/error/failure.dart';
import 'package:event_admin/features/event/domain/entity/event_entity.dart';


abstract class EventRepository {
  Future<Either<Failure, List<EventEntity>>> load();

  Future<Either<Failure, String>> delete({required String id});

  Future<Either<Failure, String>> create({required EventEntity param});
  Future<Either<Failure, String>> update({required EventEntity param});


}
