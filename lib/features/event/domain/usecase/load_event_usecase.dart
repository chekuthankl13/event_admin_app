import 'package:dartz/dartz.dart';
import 'package:event_admin/core/error/failure.dart';
import 'package:event_admin/core/usecase/usecase.dart';
import 'package:event_admin/features/event/domain/entity/event_entity.dart';
import 'package:event_admin/features/event/domain/repository/event_repository.dart';

class LoadEventUsecase extends Usecase<List<EventEntity>, NoParam> {
  final EventRepository repository;

  LoadEventUsecase({required this.repository});
  @override
  Future<Either<Failure, List<EventEntity>>> call(NoParam param) async {
    return await repository.load();
  }
}
