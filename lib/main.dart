import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healmeumpapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_bloc.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/injection/injection.dart' as di;
import 'package:healmeumpapp/core/service/flavor_config_set.dart';
import 'package:healmeumpapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:healmeumpapp/router/router_navigation.dart';
import 'package:healmeumpapp/shared/local_datasource.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDataSource().init();
  await di.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ChuckerFlutter.showOnRelease = false;
  ChuckerFlutter.showNotification = true;
  const String flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'production');
  Config.setAppFlavor(flavor);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di.sl<AuthBloc>(),
          ),
          BlocProvider(
            create: (context) => di.sl<HomeBloc>(),
          ),
          BlocProvider(create: (context) => di.sl<MentalhealthBloc>(),
          )
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return const TemplateMain();
        }));
  }
}

class TemplateMain extends StatelessWidget {
  const TemplateMain({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', 'ID'),
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: cBackground,
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: cPrimary
        ),
        dialogBackgroundColor: cPrimary,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: cPrimary,
          selectionColor: cPrimary,
          selectionHandleColor: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            ),
        textTheme: GoogleFonts.interTextTheme(textTheme).copyWith(),
      ),
      routerDelegate: RouterNavigation.router.routerDelegate,
      routeInformationParser: RouterNavigation.router.routeInformationParser,
      routeInformationProvider:
          RouterNavigation.router.routeInformationProvider,
      builder: (context, child) {
        if (Config.appFlavor == Flavor.production) return child!;
        return Banner(
          message: Config.appFlavor == Flavor.dev
              ? "Dev"
              : Config.appFlavor == Flavor.staging
                  ? "Stagging"
                  : "",
          location: BannerLocation.topEnd,
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          ),
        );
      },
    );
  }
}
