import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_margins_and_sizes.dart';
import 'package:zacatrusa/core/optional.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_categoria_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_mecanica_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_si_buscas_filter.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_tematica_filter.dart';

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
                  onChange: (value) {
                    urlComposer = urlComposer.copyWith(
                        tematica: Optional.value(value == null
                            ? null
                            : ZacatrusTematicaFilter(value: value)));
                  },
                ),
                Text("Edad contenido"),
                Text("Número de jugadores contenido"),
                Text("Precio contenido"),
                RadioButtonListFilter(
                  filterName: "Mecánica",
                  categories: ZacatrusMecanicaFilter.categories.toList(),
                  initialCategory: urlComposer.mecanica?.value,
                  onChange: (value) {
                    urlComposer = urlComposer.copyWith(
                        mecanica: Optional.value(value == null
                            ? null
                            : ZacatrusMecanicaFilter(value: value)));
                  },
                ),
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

class RadioButtonListFilter extends StatefulWidget {
  const RadioButtonListFilter({
    required this.filterName,
    required this.categories,
    required this.initialCategory,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final List<String> categories;
  final String? initialCategory;
  final Function(String?) onChange;
  final String filterName;

  @override
  State<RadioButtonListFilter> createState() => _RadioButtonListFilterState();
}

class _RadioButtonListFilterState extends State<RadioButtonListFilter> {
  String? selected;

  @override
  void initState() {
    super.initState();
    widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.filterName,
          style: Theme.of(context).textTheme.headline4,
        ),
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: widget.categories.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                return RadioListTile<String?>(
                  toggleable: true,
                  groupValue: selected,
                  value: category,
                  title: Text(category),
                  onChanged: (String? value) {
                    setState(() {
                      selected = value;
                    });
                    widget.onChange(value);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
