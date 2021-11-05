import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/presentation/core/routing/games_router_delegate.dart';

import 'constants/app_constants.dart';
import 'game_board/presentation/core/routing/game_route_information_parser.dart';

void main() {
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
      backButtonDispatcher: RootBackButtonDispatcher(),
      routeInformationParser: routeInformationParser,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color.fromRGBO(76, 176, 86, 1)),
          textTheme: const TextTheme(headline5: TextStyle(fontSize: 20))),
    );
  }
}
