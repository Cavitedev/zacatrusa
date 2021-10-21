import 'package:flutter/material.dart';
import 'package:zacatrusa/constants/app_constants.dart';
import 'package:zacatrusa/game_board/presentation/game_list/game_browse.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameBrowse(),
    );
  }
}


