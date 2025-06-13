import 'package:dartz/dartz.dart';
import 'package:event_admin/core/error/failure.dart';
import 'package:event_admin/core/usecase/usecase.dart';
import 'package:event_admin/features/event/domain/entity/event_entity.dart';
import 'package:event_admin/features/event/domain/repository/event_repository.dart';

class CreateEventUsecase extends Usecase<String, EventEntity> {
  final EventRepository repository;

  CreateEventUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(EventEntity param) async {
    return await repository.create(param: param);
  }
}
