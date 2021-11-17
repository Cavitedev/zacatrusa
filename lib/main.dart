import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
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
                headline5: TextStyle(fontSize: 24),
                headline4: TextStyle(fontSize: 28),
                headline3: TextStyle(fontSize: 36, letterSpacing: 0.5),
                headline2: TextStyle(fontSize: 44, letterSpacing: 1),
              ))),
    );
  }
}
