import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_size/window_size.dart';

import 'constants/app_constants.dart';
import 'game_board/presentation/core/routing/game_route_information_parser.dart';
import 'game_board/presentation/core/routing/games_router_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Platform.environment.containsKey('FLUTTER_TEST') &&
      (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    setWindowMinSize(const Size(350, 350));
    setWindowMaxSize(Size.infinite);
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerDelegate = ref.watch(gamesRouterDelegateProvider);
    final routeInformationParser =
        ref.watch(gameRouteInformationParserProvider);

    return MaterialApp.router(
      title: appName,
      routerDelegate: routerDelegate,
      // backButtonDispatcher: RootBackButtonDispatcher(),
      routeInformationParser: routeInformationParser,
      theme: ThemeData(
          primarySwatch: Colors.green,
          errorColor: Colors.redAccent.shade400,
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black38,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            isDense: true,
          ),
          dialogTheme: const DialogTheme(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          )),
          textTheme: const TextTheme(
            headline6: TextStyle(fontSize: 20),
            headline5: TextStyle(fontSize: 24),
            headline4: TextStyle(fontSize: 28, color: Colors.black),
            headline3: TextStyle(
                fontSize: 36, color: Colors.black, letterSpacing: 0.5),
            headline2:
                TextStyle(fontSize: 44, color: Colors.black, letterSpacing: 1),
          )),
    );
  }
}
