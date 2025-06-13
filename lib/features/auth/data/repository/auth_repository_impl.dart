import 'package:dartz/dartz.dart';
import 'package:event_admin/core/db/db_service.dart';
import 'package:event_admin/core/error/exception.dart';
import 'package:event_admin/core/error/failure.dart';
import 'package:event_admin/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:event_admin/features/auth/data/model/login_param_model.dart';
import 'package:event_admin/features/auth/domain/entity/login_param.dart';
import 'package:event_admin/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final DbService dbService;

  AuthRepositoryImpl({required this.remoteDataSource, required this.dbService});
  @override
  Future<Either<Failure, String>> login({required LoginParam param}) async {
    try {
      var res = await remoteDataSource.login(
        param: LoginParamModel.fromEntity(param),
      );
      await dbService.saveToken(res);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ExpectionFailure(error: e.toString()));
    }
  }
}
