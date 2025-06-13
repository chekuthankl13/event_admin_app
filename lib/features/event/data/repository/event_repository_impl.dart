import 'package:dartz/dartz.dart';
import 'package:event_admin/core/error/exception.dart';
import 'package:event_admin/core/error/failure.dart';
import 'package:event_admin/features/event/data/data_source/event_remote_data_source.dart';
import 'package:event_admin/features/event/data/model/event_entity_model.dart';
import 'package:event_admin/features/event/domain/entity/event_entity.dart';
import 'package:event_admin/features/event/domain/repository/event_repository.dart';

class EventRepositoryImpl extends EventRepository {
  final EventRemoteDataSource remoteDataSource;

  EventRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<EventEntity>>> load() async {
    try {
      var res = await remoteDataSource.load();
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExpectionFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, String>> delete({required String id}) async {
    try {
      var res = await remoteDataSource.delete(id: id);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExpectionFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, String>> create({required EventEntity param}) async {
    try {
      var res = await remoteDataSource.create(
        param: EventEntityModel.fromEntity(param),
      );
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExpectionFailure(error: e.error));
    }
  }
  
  @override
  Future<Either<Failure, String>> update({required EventEntity param})async {
    try {
      var res = await remoteDataSource.update(
        param: EventEntityModel.fromEntity(param),
      );
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExpectionFailure(error: e.error));
    }
  }
}
