import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/color_x.dart';
import '../core/routing/games_router_delegate.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double textScaleFactor = MediaQuery.textScaleFactorOf(context);
    double iconSize = 26 * textScaleFactor;
    return SizedBox(
      width: ResponsiveValue(context, defaultValue: 250.0, valueWhen: [
        const Condition.largerThan(name: MOBILE, value: 350.0),
        const Condition.largerThan(name: TABLET, value: 550.0)
      ]).value,
      child: Drawer(
        semanticLabel: "Navegación de $appName",
        child: ListView(
          padding: EdgeInsets.zero,
          primary: false,
          children: [
            SizedBox(
              height: textScaleFactor > 1.5
                  ? ResponsiveValue(context, defaultValue: 150.0, valueWhen: [
                      const Condition.smallerThan(name: DESKTOP, value: 250.0),
                    ]).value
                  : 150.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Semantics(
                  label: "Título de la navegación",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  onTapHint: "Salir de la navegación",
                  child: ExcludeSemantics(
                    child: Text(
                      appName,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          height: 1.2,
                          color: Theme.of(context)
                              .primaryColor
                              .textColorForThisBackground()),
                    ),
                  ),
                ),
              ),
            ),
            CustomDrawerListTile(
              leading: Text("🎲",
                  style: TextStyle(
                      fontSize:
                          iconSize / MediaQuery.textScaleFactorOf(context))),
              title: Text(
                "Dado",
                style: Theme.of(context).textTheme.headline5,
              ),
              onTapCallback: () {
                final router = ref.read(gamesRouterDelegateProvider);
                router.currentConf = router.currentConf.copyWith(dice: true);
              },
            ),
            CustomDrawerListTile(
              title: Text(
                "Compartir app",
                style: Theme.of(context).textTheme.headline5,
              ),
              leading: Icon(
                Icons.share,
                color: Colors.black54,
                size: iconSize,
              ),
              onTapCallback: () {
                Share.share(appWebsiteDownload);
              },
            ),
            CustomDrawerListTile(
              title: Text(
                "Ajustes",
                style: Theme.of(context).textTheme.headline5,
              ),
              leading: Icon(
                Icons.settings,
                color: Colors.black54,
                size: iconSize,
              ),
              onTapCallback: () {
                final router = ref.read(gamesRouterDelegateProvider);
                router.currentConf =
                    router.currentConf.copyWith(settings: true);
              },
            ), //
            CustomDrawerListTile(
              title: Text(
                "Salir",
                style: Theme.of(context).textTheme.headline5,
              ),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black54,
                size: iconSize,
              ),
              onTapCallback: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else {
                  exit(0);
                }
              },
            ) // O
          ],
        ),
      ),
    );
  }
}

class CustomDrawerListTile extends StatelessWidget {
  const CustomDrawerListTile({
    required this.leading,
    required this.title,
    required this.onTapCallback,
    Key? key,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final Function onTapCallback;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: leading,
            ),
            Flexible(child: title)
          ],
        ),
        Positioned.fill(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    onTapCallback();
                  },
                )))
      ],
    );
  }
}
