import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/app_constants.dart';
import 'game_board/presentation/games_browse/games_browse.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
          appBarTheme:
              const AppBarTheme(color: Color.fromRGBO(76, 176, 86, 1))),
      home: const GamesBrowse(),
    );
  }
}
