import 'package:dartz/dartz.dart';
import 'package:event_admin/core/error/failure.dart';
import 'package:event_admin/features/auth/domain/entity/login_param.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login({required LoginParam param});
}
