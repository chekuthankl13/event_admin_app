import 'package:dartz/dartz.dart';
import 'package:event_admin/core/error/failure.dart';
import 'package:event_admin/core/usecase/usecase.dart';
import 'package:event_admin/features/event/domain/repository/event_repository.dart';

class DeleteEventUsecase extends Usecase<String, String> {
  final EventRepository repository;

  DeleteEventUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(String param) async {
    return await repository.delete(id: param);
  }
}
