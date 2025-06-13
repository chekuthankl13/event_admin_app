import 'package:dartz/dartz.dart';
import 'package:event_admin/core/error/failure.dart';
import 'package:event_admin/core/usecase/usecase.dart';
import 'package:event_admin/features/auth/domain/entity/login_param.dart';
import 'package:event_admin/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase extends Usecase<String, LoginParam> {
  final AuthRepository repository;

  LoginUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(LoginParam param) async {
    return await repository.login(param: param);
  }
}
