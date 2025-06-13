import 'dart:convert';
import 'dart:developer';

import 'package:event_admin/core/config/config.dart';
import 'package:event_admin/core/error/exception.dart';
import 'package:event_admin/core/error/failure.dart';
import 'package:event_admin/features/auth/data/model/login_param_model.dart';
import 'package:http/http.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> login({required LoginParamModel param});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<String> login({required LoginParamModel param}) async {
    try {
      var res = await client.post(
        Uri.parse(Config.loginUrl),
        body: param.toJson(),
      );

      // var res = await client.get(Uri.parse(Config.DUMMY));
      // log(res.body);
      var body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return body['token'];
      } else {
        throw CredentialFailure(error: body['message'] + "\n" + body['error']);
      }
    } on Exception catch (e) {
      log(e.toString());
      throw ServerException(error: e.toString());
    }
  }
}
