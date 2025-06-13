import 'package:event_admin/core/db/db_service.dart';
import 'package:event_admin/features/auth/di/auth_di.dart';
import 'package:event_admin/features/event/di/event_di.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

var sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => http.Client());
  sl.registerFactory(() => DbService());

  await authInit(sl);
  await eventInit(sl);
}
