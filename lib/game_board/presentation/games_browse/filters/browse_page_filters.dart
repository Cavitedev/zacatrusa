import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_margins_and_sizes.dart';
import 'package:zacatrusa/core/optional.dart';
import 'package:zacatrusa/game_board/presentation/games_browse/filters/radio_button_filter_list.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_categoria_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_edades_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_editorial_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_mecanica_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_num_jugadores_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_si_buscas_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_tematica_filter.dart';

import '../../../application/browser/browser_notifier.dart';
import '../../../zacatrus/domain/url/zacatrus_url_composer.dart';
import 'checkbox_filter_list.dart';

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
    tabController = TabController(length: 8, vsync: this);
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
              Tab(child: Text("Si Buscas")),
              Tab(child: Text("Categoría")),
              Tab(child: Text("Temática")),
              Tab(child: Text("Edad")),
              Tab(child: Text("Número de Jugadores")),
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
                RadioButtonListFilter(
                  filterName: "Si Buscas...",
                  categories: ZacatrusSiBuscasFilter.categories.toList(),
                  initialCategory: urlComposer.siBuscas?.value,
                  onChange: (value) {
                    urlComposer = urlComposer.copyWith(
                        siBuscas: Optional.value(value == null
                            ? null
                            : ZacatrusSiBuscasFilter(value: value)));
                  },
                ),
                RadioButtonListFilter(
                  filterName: "Categoría",
                  categories: ZacatrusCategoriaFilter.categories.toList(),
                  initialCategory: urlComposer.categoria?.value,
                  onChange: (value) {
                    urlComposer = urlComposer.copyWith(
                        categoria: Optional.value(value == null
                            ? null
                            : ZacatrusCategoriaFilter(value: value)));
                  },
                ),
                RadioButtonListFilter(
                  filterName: "Temática",
                  categories: ZacatrusTematicaFilter.categories.toList(),
                  initialCategory: urlComposer.tematica?.value,
                  searchEnabled: true,
                  onChange: (value) {
                    urlComposer = urlComposer.copyWith(
                        tematica: Optional.value(value == null
                            ? null
                            : ZacatrusTematicaFilter(value: value)));
                  },
                ),
                CheckboxListFilter(
                  filterName: "Edad",
                  categories: ZacatrusEdadesFilter.categories.toList(),
                  initialCategories: urlComposer.edades?.values ?? [],
                  onChange: (values) {
                    urlComposer = urlComposer.copyWith(
                        edades: Optional.value(values.isEmpty
                            ? null
                            : ZacatrusEdadesFilter(values: values)));
                  },
                ),
                CheckboxListFilter(
                  filterName: "Número de Jugadores",
                  categories: ZacatrusNumJugadoresFilter.categories.toList(),
                  initialCategories: urlComposer.numJugadores?.values ?? [],
                  onChange: (values) {
                    urlComposer = urlComposer.copyWith(
                        numJugadores: Optional.value(values.isEmpty
                            ? null
                            : ZacatrusNumJugadoresFilter(values: values)));
                  },
                ),
                Text("Precio contenido"),
                RadioButtonListFilter(
                  filterName: "Mecánica",
                  categories: ZacatrusMecanicaFilter.categories.toList(),
                  initialCategory: urlComposer.mecanica?.value,
                  searchEnabled: true,
                  onChange: (value) {
                    urlComposer = urlComposer.copyWith(
                        mecanica: Optional.value(value == null
                            ? null
                            : ZacatrusMecanicaFilter(value: value)));
                  },
                ),
                RadioButtonListFilter(
                  filterName: "Editorial",
                  categories: ZacatrusEditorialFilter.categories.toList(),
                  initialCategory: urlComposer.editorial?.value,
                  searchEnabled: true,
                  onChange: (value) {
                    urlComposer = urlComposer.copyWith(
                        editorial: Optional.value(value == null
                            ? null
                            : ZacatrusEditorialFilter(value: value)));
                  },
                ),
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
