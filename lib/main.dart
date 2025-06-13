import 'package:event_admin/core/di/di.dart';
import 'package:event_admin/core/routes/app_routes.dart';
import 'package:event_admin/core/theme/app_theme.dart';
import 'package:event_admin/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "EVENT ADMIN",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      navigatorKey: navigatorKey,
      initialRoute: '/splash',
      onGenerateRoute: AppRoutes().route,
      builder: EasyLoading.init(),
    );
  }
}
