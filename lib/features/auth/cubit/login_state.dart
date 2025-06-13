part of 'login_cubit.dart';

@freezed
sealed class LoginState with _$LoginState {
  const LoginState._();
  const factory LoginState.initial() = Initial;
  const factory LoginState.loading() = Loading;
  const factory LoginState.error({required String erro}) = Error;
  const factory LoginState.success({required String token}) = Success;

}
