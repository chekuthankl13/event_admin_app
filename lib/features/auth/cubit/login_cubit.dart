import 'package:event_admin/features/auth/data/model/login_param_model.dart';
import 'package:event_admin/features/auth/domain/usecase/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  LoginCubit(this.loginUsecase) : super(LoginState.initial());

  login({email, password}) async {
    try {
      emit(LoginState.loading());
      var res = await loginUsecase(
        LoginParamModel(email: email, password: password),
      );
      res.fold(
        (l) => emit(LoginState.error(erro: l.error)),
        (r) => emit(LoginState.success(token: r)),
      );
    } catch (e) {
      emit(LoginState.error(erro: e.toString()));
    }
  }
}
