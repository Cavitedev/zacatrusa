import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/color_x.dart';

import '../../../constants/app_constants.dart';
import '../core/routing/games_router_delegate.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      semanticLabel: "Navegación de la aplicación",
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                appName,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Theme.of(context)
                        .primaryColor
                        .textColorForThisBackground()),
              )),
          ListTile(
            title: Text(
              "Ajustes",
              style: Theme.of(context).textTheme.headline4,
            ),
            leading: const Icon(
              Icons.settings,
              size: 32,
            ),
            onTap: () {
              final router = ref.read(gamesRouterDelegateProvider);
              router.currentConf = router.currentConf.copyWith(settings: true);
            },
          ), //
          ListTile(
            title: Text(
              "Salir",
              style: Theme.of(context).textTheme.headline4,
            ),
            leading: const Icon(
              Icons.exit_to_app,
              size: 32,
            ),
            onTap: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else {
                exit(0);
              }
            },
          ) // O
        ],
      ),
    );
  }
}
