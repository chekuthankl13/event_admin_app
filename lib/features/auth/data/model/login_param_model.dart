import 'package:event_admin/features/auth/domain/entity/login_param.dart';

class LoginParamModel extends LoginParam {
  LoginParamModel({required super.email, required super.password});

  factory LoginParamModel.fromEntity(LoginParam data) =>
      LoginParamModel(email: data.email, password: data.password);

  Map<String, String> toJson() => {
    "email":email,
    "password":password
  };
}
