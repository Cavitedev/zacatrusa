import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_margins_and_sizes.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_si_buscas_filter.dart';

import '../../../application/browser/browser_notifier.dart';
import '../../../zacatrus/domain/url/zacatrus_url_composer.dart';

class BrowsePageFilters extends ConsumerStatefulWidget {
  const BrowsePageFilters({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _GameBrowseFiltersState();
}

class _GameBrowseFiltersState extends ConsumerState<BrowsePageFilters>
    with SingleTickerProviderStateMixin {
  late ZacatrusUrlBrowserComposer urlComposer;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 9, vsync: this);
    urlComposer = ref.read(browserNotifierProvider).urlComposer;
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: const [
              Tab(child: Text("Si buscas")),
              Tab(child: Text("Categoría")),
              Tab(child: Text("Novedad")),
              Tab(child: Text("Temática")),
              Tab(child: Text("Edad")),
              Tab(child: Text("Número de jugadores")),
              Tab(child: Text("Precio")),
              Tab(child: Text("Mecánica")),
              Tab(child: Text("Editorial"))
            ],
            controller: tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                SiBuscasFilter(),
                Text("Categoría contenido"),
                Text("Novedad contenido"),
                Text("Temática contenido"),
                Text("Edad contenido"),
                Text("Número de jugadores contenido"),
                Text("Precio contenido"),
                Text("Mecánica contenido"),
                Text("Editorial contenido"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(generalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      ref
                          .read(browserNotifierProvider.notifier)
                          .changeFilters(urlComposer);
                      Navigator.pop(context);
                    },
                    child: const Text("Aceptar"))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SiBuscasFilter extends StatefulWidget {
  const SiBuscasFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<SiBuscasFilter> createState() => _SiBuscasFilterState();
}

class _SiBuscasFilterState extends State<SiBuscasFilter> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              selected = null;
            });
          },
          child: Text("Limpiar"),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColorDark,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Si buscas..."),
                ...ZacatrusSiBuscasFilter.categories.map(
                  (category) => RadioListTile<String?>(
                    toggleable: true,
                    groupValue: selected,
                    value: category,
                    title: Text(category),
                    onChanged: (String? value) {
                      setState(() {
                        selected = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
