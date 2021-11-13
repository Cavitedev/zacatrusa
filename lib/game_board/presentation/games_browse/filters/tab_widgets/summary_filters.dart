import 'package:flutter/material.dart';

import '../../../../../constants/app_margins_and_sizes.dart';
import '../../../../../core/optional.dart';
import '../../../../zacatrus/domain/url/zacatrus_url_composer.dart';

class SummaryFilters extends StatelessWidget {
  const SummaryFilters({
    required this.urlComposer,
    required this.onComposerUpdate,
    Key? key,
  }) : super(key: key);

  final ZacatrusUrlBrowserComposer urlComposer;
  final Function(ZacatrusUrlBrowserComposer) onComposerUpdate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: generalPadding),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            "Resumen",
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          Text(
            "Filtros Seleccionados:",
            style: Theme.of(context).textTheme.headline6,
          ),
          if (urlComposer.siBuscas != null)
            SummaryFilterElement(
              labelName: "Si Buscas: ",
              valueName: urlComposer.siBuscas!.value,
              onClear: () {
                onComposerUpdate(urlComposer.copyWith(
                  siBuscas: const Optional.value(null),
                ));
              },
            ),
          if (urlComposer.categoria != null)
            SummaryFilterElement(
              labelName: "Categoría: ",
              valueName: urlComposer.categoria!.value,
              onClear: () {
                onComposerUpdate(urlComposer.copyWith(
                  categoria: const Optional.value(null),
                ));
              },
            ),
          if (urlComposer.tematica != null)
            SummaryFilterElement(
              labelName: "Temática: ",
              valueName: urlComposer.tematica!.value,
              onClear: () {
                onComposerUpdate(urlComposer.copyWith(
                  tematica: const Optional.value(null),
                ));
              },
            ),
          if (urlComposer.edades != null)
            SummaryFilterElement(
              labelName: "Edades: ",
              valueName: urlComposer.edades!.values.join(", "),
              onClear: () {
                onComposerUpdate(urlComposer.copyWith(
                  edades: const Optional.value(null),
                ));
              },
            ),
          if (urlComposer.numJugadores != null)
            SummaryFilterElement(
              labelName: "Número de Jugadores: ",
              valueName: urlComposer.numJugadores!.values.join(", "),
              onClear: () {
                onComposerUpdate(urlComposer.copyWith(
                  numJugadores: const Optional.value(null),
                ));
              },
            ),
          if (urlComposer.precio != null)
            SummaryFilterElement(
              labelName: "Precio: ",
              valueName: urlComposer.precio!.toString(),
              onClear: () {
                onComposerUpdate(urlComposer.copyWith(
                  precio: const Optional.value(null),
                ));
              },
            ),
          if (urlComposer.mecanica != null)
            SummaryFilterElement(
              labelName: "Mecánica: ",
              valueName: urlComposer.mecanica!.toString(),
              onClear: () {
                onComposerUpdate(urlComposer.copyWith(
                  mecanica: const Optional.value(null),
                ));
              },
            ),
          if (urlComposer.editorial != null)
            SummaryFilterElement(
              labelName: "Editorial: ",
              valueName: urlComposer.editorial!.toString(),
              onClear: () {
                onComposerUpdate(urlComposer.copyWith(
                  editorial: const Optional.value(null),
                ));
              },
            ),
        ],
      ),
    );
  }
}

class SummaryFilterElement extends StatelessWidget {
  const SummaryFilterElement({
    Key? key,
    required this.labelName,
    required this.valueName,
    required this.onClear,
  }) : super(key: key);

  final Function() onClear;
  final String labelName;
  final String valueName;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                onClear();
              },
              icon: const Icon(Icons.clear)),
          Flexible(
            child: Row(
              children: [
                Flexible(
                    child: SelectableText(
                  labelName,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.w500),
                )),
                Flexible(
                    child: SelectableText(valueName,
                        style: Theme.of(context).textTheme.subtitle1))
              ],
            ),
          )
        ],
      ),
    );
  }
}
