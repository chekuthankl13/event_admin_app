import 'package:event_admin/features/auth/cubit/login_cubit.dart';
import 'package:event_admin/features/auth/presentation/login_screen.dart';
import 'package:event_admin/features/event/cubit/event_cubit.dart';
import 'package:event_admin/features/event/domain/entity/event_arguments.dart';
import 'package:event_admin/features/event/presentation/event_create_update_screen.dart';
import 'package:event_admin/features/event/presentation/home_screen.dart';
import 'package:event_admin/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../di/di.dart';

class AppRoutes {
  Route? route(RouteSettings setting) {
    switch (setting.name) {
      case "/splash":
        return page(child: const SplashScreen());

      case "/login":
        return page(
          child: BlocProvider(
            create: (context) => sl<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
        case "/home":
        return page(
          child: BlocProvider(
            create: (context) => sl<EventCubit>()..load(),
            child:const HomeScreen(),
          ),
        );
        case "/create_update":
        var args = setting .arguments as EventArguments;
        return page(
          child: BlocProvider(
            create: (context) => sl<EventCubit>(),
            child:  EventCreateUpdateScreen(arg:args ,),
          ),
        );
      default:
        return null;
    }
  }
}

PageTransition page({required child}) =>
    PageTransition(type: PageTransitionType.fade, child: child);
