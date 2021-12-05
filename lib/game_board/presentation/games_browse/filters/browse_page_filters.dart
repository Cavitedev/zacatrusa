import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/settings/settings_controller.dart';

import '../../../../constants/app_margins_and_sizes.dart';
import '../../../../core/optional.dart';
import '../../../application/browser/browser_notifier.dart';
import '../../../zacatrus/domain/url/filters/zacatrus_categoria_filter.dart';
import '../../../zacatrus/domain/url/filters/zacatrus_edades_filter.dart';
import '../../../zacatrus/domain/url/filters/zacatrus_editorial_filter.dart';
import '../../../zacatrus/domain/url/filters/zacatrus_mecanica_filter.dart';
import '../../../zacatrus/domain/url/filters/zacatrus_num_jugadores_filter.dart';
import '../../../zacatrus/domain/url/filters/zacatrus_rango_precio_filter.dart';
import '../../../zacatrus/domain/url/filters/zacatrus_si_buscas_filter.dart';
import '../../../zacatrus/domain/url/filters/zacatrus_tematica_filter.dart';
import '../../../zacatrus/domain/url/zacatrus_url_composer.dart';
import '../warning_query_search.dart';
import 'tab_widgets/checkbox_filter_list.dart';
import 'tab_widgets/radio_button_filter_list.dart';
import 'tab_widgets/slider_filter.dart';
import 'tab_widgets/summary_filters.dart';

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
  bool _forBuilding = false;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    urlComposer = ref.read(browserNotifierProvider).urlComposer;

    tabController = TabController(
        length: 9,
        vsync: this,
        initialIndex: urlComposer.areThereFilters ? 0 : 1);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: const [
              Tab(text: "Resumen"),
              Tab(text: "Si Buscas"),
              Tab(text: "Categoría"),
              Tab(text: "Temática"),
              Tab(text: "Edad"),
              Tab(text: "Número de Jugadores"),
              Tab(text: "Precio"),
              Tab(text: "Mecánica"),
              Tab(text: "Editorial")
            ],
            controller: tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                SummaryFilters(
                  urlComposer: urlComposer,
                  onComposerUpdate: (composer) {
                    setState(() {
                      urlComposer = composer;
                    });
                  },
                ),
                RadioButtonListFilter(
                  filterName: "Si Buscas...",
                  categories: ZacatrusSiBuscasFilter.categories.toList(),
                  initialCategory: urlComposer.siBuscas?.value,
                  onChange: (value) {
                    setState(() {
                      urlComposer = urlComposer.copyWith(
                          siBuscas: Optional.value(value == null
                              ? null
                              : ZacatrusSiBuscasFilter(value: value)));
                    });
                  },
                ),
                RadioButtonListFilter(
                  key: ValueKey("Categoría $_forBuilding"),
                  filterName: "Categoría",
                  categories: ZacatrusCategoriaFilter.categories.toList(),
                  initialCategory: urlComposer.categoria?.value,
                  onChange: (value) {
                    setState(() {
                      final newComposer = urlComposer.copyWith(
                          categoria: Optional.value(value == null
                              ? null
                              : ZacatrusCategoriaFilter(value: value)));

                      if (_shouldShowDowngradeQuertDialog(newComposer)) {
                        _showDrowngradeQuerySearchWarningDialog(
                            newComposer, context);
                        return;
                      }

                      urlComposer = newComposer;
                    });
                  },
                ),
                RadioButtonListFilter(
                  filterName: "Temática",
                  categories: ZacatrusTematicaFilter.categories.toList(),
                  initialCategory: urlComposer.tematica?.value,
                  searchEnabled: true,
                  onChange: (value) {
                    setState(() {
                      urlComposer = urlComposer.copyWith(
                          tematica: Optional.value(value == null
                              ? null
                              : ZacatrusTematicaFilter(value: value)));
                    });
                  },
                ),
                CheckboxListFilter(
                  key: ValueKey("Edad $_forBuilding"),
                  filterName: "Edad",
                  categories: ZacatrusEdadesFilter.categories.toList(),
                  initialCategories: [...urlComposer.edades?.values ?? []],
                  onChange: (values) {
                    setState(() {
                      final newComposer = urlComposer.copyWith(
                          edades: Optional.value(values.isEmpty
                              ? null
                              : ZacatrusEdadesFilter(values: values)));
                      if (_shouldShowDowngradeQuertDialog(newComposer)) {
                        _showDrowngradeQuerySearchWarningDialog(
                            newComposer, context);
                        return;
                      }

                      urlComposer = newComposer;
                    });
                  },
                ),
                CheckboxListFilter(
                  filterName: "Número de Jugadores",
                  categories: ZacatrusNumJugadoresFilter.categories.toList(),
                  initialCategories: urlComposer.numJugadores?.values ?? [],
                  onChange: (values) {
                    setState(() {
                      urlComposer = urlComposer.copyWith(
                          numJugadores: Optional.value(values.isEmpty
                              ? null
                              : ZacatrusNumJugadoresFilter(values: values)));
                    });
                  },
                ),
                SliderFilter(
                  key: ValueKey("Filter Precio $_forBuilding"),
                  filterName: "Precio",
                  minValue: ZacatrusRangoPrecioFilter.minValue,
                  maxValue: ZacatrusRangoPrecioFilter.maxValue,
                  initialMinValue: urlComposer.precio?.min ??
                      ZacatrusRangoPrecioFilter.minValue,
                  initialMaxValue: urlComposer.precio?.max ??
                      ZacatrusRangoPrecioFilter.maxValue,
                  onChange: (newMinValue, newMaxValue) {
                    setState(() {
                      final newComposer = urlComposer.copyWith(
                          precio: Optional.value(ZacatrusRangoPrecioFilter(
                              min: newMinValue, max: newMaxValue)));

                      if (_shouldShowDowngradeQuertDialog(newComposer)) {
                        _showDrowngradeQuerySearchWarningDialog(
                            newComposer, context);
                        return;
                      }
                      urlComposer = newComposer;
                    });
                  },
                ),
                RadioButtonListFilter(
                  filterName: "Mecánica",
                  categories: ZacatrusMecanicaFilter.categories.toList(),
                  initialCategory: urlComposer.mecanica?.value,
                  searchEnabled: true,
                  onChange: (value) {
                    setState(() {
                      urlComposer = urlComposer.copyWith(
                          mecanica: Optional.value(value == null
                              ? null
                              : ZacatrusMecanicaFilter(value: value)));
                    });
                  },
                ),
                RadioButtonListFilter(
                  key: ValueKey("Filter Editorial $_forBuilding"),
                  filterName: "Editorial",
                  categories: ZacatrusEditorialFilter.categories.toList(),
                  initialCategory: urlComposer.editorial?.value,
                  searchEnabled: true,
                  onChange: (value) {
                    setState(() {
                      final newComposer = urlComposer.copyWith(
                          editorial: Optional.value(value == null
                              ? null
                              : ZacatrusEditorialFilter(value: value)));

                      if (_shouldShowDowngradeQuertDialog(newComposer)) {
                        _showDrowngradeQuerySearchWarningDialog(
                            newComposer, context);
                        return;
                      }

                      urlComposer = newComposer;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(generalPadding),
            child: Align(
              alignment: Alignment.centerRight,
              child: Wrap(
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
            ),
          )
        ],
      ),
    );
  }

  /// True if this method handles changing the url notifier
  void _showDrowngradeQuerySearchWarningDialog(
      ZacatrusUrlBrowserComposer newComposer, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return DowngradeQuerySearchWarningDialog(
            onAccept: () {
              setState(() {
                urlComposer = newComposer;
              });
            },
            onDismiss: () {
              setState(() {
                _forBuilding = !_forBuilding;
              });
            },
          );
        });
  }

  bool _shouldShowDowngradeQuertDialog(ZacatrusUrlBrowserComposer newComposer) {
    return !newComposer.canSearchBeComplete &&
        !ref.read(settingsControllerProvider).notifyQueryDowngradeWarning;
  }
}
