import 'dart:async';

import 'package:event_admin/core/db/db_service.dart';
import 'package:event_admin/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'core/di/di.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () async {
      String token = sl<DbService>().getToken();

      if (token.isEmpty) {
        navigatorKey.currentState!.pushReplacementNamed("/login");
      } else {
        tokenValidation(token);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: loading());
  }
}

void tokenValidation(token) async {
  bool isExperied = JwtDecoder.isExpired(token);
  if (isExperied) {
    navigatorKey.currentState!.pushReplacementNamed("/login");
  } else {
    navigatorKey.currentState!.pushReplacementNamed("/home");
  }
}
