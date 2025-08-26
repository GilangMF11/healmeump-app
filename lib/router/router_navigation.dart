import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healmeumpapp/features/auth/presentation/pages/login_page.dart';
import 'package:healmeumpapp/features/onbroading/presentation/onbroading_page.dart';
import 'package:healmeumpapp/router/pages_names.dart';

class RouterNavigation {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: PAGESNAMES.onbroading.ScreenPath,
    observers: [ChuckerFlutter.navigatorObserver],
    routes: [
      // GoRoute(
      //   path: PAGESNAMES.splashScreen.ScreenPath,
      //   name: PAGESNAMES.splashScreen.ScreenName,
      //   builder: (context, state) => const SplashscreenPage(),
      // ),

      GoRoute(
        path: PAGESNAMES.onbroading.ScreenPath,
        name: PAGESNAMES.onbroading.ScreenName,
        builder: (context, state) => const OnbroadingPage(),
      ),

      GoRoute(
        path: PAGESNAMES.login.ScreenPath,
        name: PAGESNAMES.login.ScreenName,
        builder: (context, state) => const LoginPage(),
      ),

      // GoRoute(
      //   path: PAGESNAMES.home.ScreenPath,
      //   name: PAGESNAMES.home.ScreenName,
      //   builder: (context, state) => const NavigationBottomPage(),
      // ),

      
    ],
  );
  static GoRouter get router => _router;
}
