import 'dart:convert';

import 'package:event_admin/core/config/config.dart';
import 'package:event_admin/core/db/db_service.dart';
import 'package:event_admin/core/error/exception.dart';
import 'package:event_admin/core/error/failure.dart';
import 'package:event_admin/features/event/data/model/event_entity_model.dart';
import 'package:http/http.dart';

abstract interface class EventRemoteDataSource {
  Future<List<EventEntityModel>> load();
  Future<String> delete({required String id});

  Future<String> create({required EventEntityModel param});
  Future<String> update({required EventEntityModel param});


}

class EventRemoteDataSourceImpl extends EventRemoteDataSource {
  final Client client;
  final DbService dbService;

  EventRemoteDataSourceImpl({required this.client, required this.dbService});

  Map<String, String> getheaders(token) => {'Authorization': "Bearer $token"};

  @override
  Future<List<EventEntityModel>> load() async {
    try {
      List<EventEntityModel> history = [];

      var res = await client.get(
        Uri.parse(Config.eventUrl),
        headers: getheaders(dbService.getToken()),
      );

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        if ((body['data'] as List).isNotEmpty) {
          var i = (body['data'] as List<dynamic>)
              .map((e) => EventEntityModel.fromJson(e))
              .toList();
          return i;
        } else {
          return history;
        }
      } else {
        throw ServerFailure(error: res.body);
      }
    } on Exception catch (e) {
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<String> delete({required String id}) async {
    try {
      var res = await client.delete(
        Uri.parse("${Config.eventUrl}/$id"),
        headers: getheaders(dbService.getToken()),
      );
      var body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return body['message'];
      } else {
        throw CredentialFailure(error: body['message'] + "\n" + body['error']);
      }
    } on Exception catch (e) {
      throw ServerException(error: e.toString());
    }
  }
  
  @override
  Future<String> create({required EventEntityModel param}) async{
    try {
      var res = await client.post(
        Uri.parse(Config.eventUrl),
        headers: getheaders(dbService.getToken()),
        body: param.toJson()
      );
      var body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return body['message'];
      } else {
        throw CredentialFailure(error: body['message'] + "\n" + body['error']);
      }
    } on Exception catch (e) {
      throw ServerException(error: e.toString());
    }
  }
  
  @override
  Future<String> update({required EventEntityModel param}) async{
   try {
      var res = await client.put(
        Uri.parse("${Config.eventUrl}/${param.id}"),
        headers: getheaders(dbService.getToken()),
        body: param.toJson(),
      );
      var body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return body['message'];
      } else {
        throw CredentialFailure(error: body['message'] + "\n" + body['error']);
      }
    } on Exception catch (e) {
      throw ServerException(error: e.toString());
    }
  }
}
