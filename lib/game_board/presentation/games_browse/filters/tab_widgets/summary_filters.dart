import 'package:flutter/material.dart';
import 'package:zacatrusa/constants/app_margins_and_sizes.dart';
import 'package:zacatrusa/core/optional.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';

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
              labelName: "Categoría: wdwedewfew ew ",
              valueName: urlComposer.categoria!.value,
              onClear: () {
                onComposerUpdate(urlComposer.copyWith(
                  categoria: const Optional.value(null),
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
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                onClear();
              },
              icon: const Icon(Icons.clear)),
          Flexible(
            child: SelectableText.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: labelName,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  TextSpan(
                    text: valueName,
                  ),
                ],
                style:
                    Theme.of(context).textTheme.subtitle1!.copyWith(height: 1),
              ),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
