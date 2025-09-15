import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healmeumpapp/features/auth/presentation/pages/login_page.dart';
import 'package:healmeumpapp/features/home/presentation/pages/about_page.dart';
import 'package:healmeumpapp/features/home/presentation/pages/home_page.dart';
import 'package:healmeumpapp/features/home/presentation/pages/support_page.dart';
import 'package:healmeumpapp/features/mental_health/presentation/pages/mental_health/mental_health_counting_page.dart';
import 'package:healmeumpapp/features/mental_health/presentation/pages/mental_health/mental_health_page.dart';
import 'package:healmeumpapp/features/mental_health/presentation/pages/mental_health/mental_health_result_page.dart';
import 'package:healmeumpapp/features/onbroading/presentation/onbroading_page.dart';
import 'package:healmeumpapp/features/splahscreen/splashScreen_page.dart';
import 'package:healmeumpapp/router/pages_names.dart';

class RouterNavigation {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: PAGESNAMES.splashScreen.ScreenPath,
    observers: [ChuckerFlutter.navigatorObserver],
    routes: [
      GoRoute(
        path: PAGESNAMES.splashScreen.ScreenPath,
        name: PAGESNAMES.splashScreen.ScreenName,
        builder: (context, state) => const SplashscreenPage(),
      ),

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

      GoRoute(
        path: PAGESNAMES.home.ScreenPath,
        name: PAGESNAMES.home.ScreenName,
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: PAGESNAMES.mentalHealth.ScreenPath,
        name: PAGESNAMES.mentalHealth.ScreenName,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final questionnaireCode = extra['questionnaireCode'];
          final userId = extra['userId'];
          final namaPegawai = extra['namaPegawai'];
          final nip = extra['nip'];
          final jenisPegawai = extra['jenisPegawai'];
          final prodi = extra['prodi'];
          final email = extra['email'];
          final hp = extra['hp'];
          return MentalHealthPage(
            questionnaireCode: questionnaireCode,
            userId: userId,
            namaPegawai: namaPegawai,
            nip: nip,
            jenisPegawai: jenisPegawai,
            prodi: prodi,
            email: email,
            hp: hp,
          );
        },
      ),

      GoRoute(
        path: PAGESNAMES.mentalHealthCounting.ScreenPath,
        name: PAGESNAMES.mentalHealthCounting.ScreenName,
        builder: (context, state) => const MentalHealthCountingPage(),
      ),

      GoRoute(
        path: PAGESNAMES.mentalHealthResult.ScreenPath,
        name: PAGESNAMES.mentalHealthResult.ScreenName,
        builder: (context, state) => const MentalHealthResultPage(),
      ),

      GoRoute(
        path: PAGESNAMES.about.ScreenPath,
        name: PAGESNAMES.about.ScreenName,
        builder: (context, state) => const AboutPage(),
      ),

      GoRoute(
        path: PAGESNAMES.support.ScreenPath,
        name: PAGESNAMES.support.ScreenName,
        builder: (context, state) => const SupportPage(),
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
