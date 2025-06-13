import 'package:get_storage/get_storage.dart';

class DbService {
  final _storage = GetStorage();
  String getToken() => _storage.read("token") ?? "";

  Future saveToken(token) async {
    await _storage.write("token", token);
  }

  Future clear() async {
    await _storage.remove("token");
  }
}
