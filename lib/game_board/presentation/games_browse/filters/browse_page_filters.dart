import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/zacatrus/application/browser/zacatrus_browser_notifier.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';

class BrowsePageFilters extends ConsumerStatefulWidget {
  const BrowsePageFilters({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _GameBrowseFiltersState();
}

class _GameBrowseFiltersState extends ConsumerState<BrowsePageFilters> {

  late ZacatrusUrlBrowserComposer urlComposer;

  @override
  void initState() {
    super.initState();
    urlComposer = ref.read(zacatrusBrowserNotifierProvider).urlComposer;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Filtros"),
      content: const Text("Aquí se seleccionarán los filtros"),
      scrollable: true,

      actions: [ElevatedButton(onPressed: () {
        ref.read(zacatrusBrowserNotifierProvider.notifier).changeFilters(urlComposer);
      }, child: const Text("Aceptar"))],
    );
  }
}
