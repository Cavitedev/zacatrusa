import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:window_size/window_size.dart';

import 'constants/app_constants.dart';
import 'game_board/presentation/core/routing/game_route_information_parser.dart';
import 'game_board/presentation/core/routing/games_router_delegate.dart';
import 'settings/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Platform.environment.containsKey('FLUTTER_TEST') &&
      (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    setWindowMinSize(const Size(350, 350));
    setWindowMaxSize(Size.infinite);
  }

  await SettingsController.singleton().loadSettings();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerDelegate = ref.read(gamesRouterDelegateProvider);
    final routeInformationParser = ref.read(gameRouteInformationParserProvider);

    return MaterialApp.router(
      title: appName,
      routerDelegate: routerDelegate,
      backButtonDispatcher: RootBackButtonDispatcher(),
      routeInformationParser: routeInformationParser,
      locale: const Locale('es', ''),
      supportedLocales: const [Locale('es', '')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      builder: (context, widget) {
        return ResponsiveWrapper.builder(ClampingScrollWrapper.builder(context, widget!),
            mediaQueryData:
                MediaQuery.of(context).copyWith(textScaleFactor: ref.watch(settingsFontSizeControllerProvider)),
            breakpoints: const [
              ResponsiveBreakpoint.resize(250, name: MOBILE),
              ResponsiveBreakpoint.resize(400, name: PHONE),
              ResponsiveBreakpoint.resize(600, name: TABLET),
              ResponsiveBreakpoint.resize(800, name: DESKTOP),
            ]);
      },
      theme: ThemeData(
          primarySwatch: ref.watch(settingsPrimaryColorControllerProvider),
          errorColor: Colors.redAccent.shade400,
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black38,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            fillColor: Colors.black12,
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
          ),
          dialogTheme: const DialogTheme(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          )),
          textTheme: GoogleFonts.getTextTheme(
              ref.watch(settingsFontFamilyControllerProvider),
              const TextTheme(
                headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                headline5: TextStyle(fontSize: 24, color: Colors.black),
                headline4: TextStyle(fontSize: 28, color: Colors.black),
                headline3: TextStyle(fontSize: 36, letterSpacing: 0.5, color: Colors.black),
                headline2: TextStyle(fontSize: 44, letterSpacing: 1),
                bodyText1: TextStyle(height: 1),
                bodyText2: TextStyle(height: 1),
                caption: TextStyle(height: 1),
                button: TextStyle(height: 1),
                overline: TextStyle(height: 1),
                subtitle1: TextStyle(height: 1),
                subtitle2: TextStyle(height: 1),
              ))),
    );
  }
}
