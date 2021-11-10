import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/optional.dart';
import '../../../../application/browser/browser_notifier.dart';
import '../../../../zacatrus/domain/url/filters/zacatrus_order.dart';

class SortGamesWidget extends ConsumerStatefulWidget {
  const SortGamesWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SortGamesWidget> createState() => _SortGamesWidget();
}

class _SortGamesWidget extends ConsumerState<SortGamesWidget> {
  String initOrder = categoriesUrl.keys.first;

  static Map<String, ZacatrusOrder> categoriesUrl = {
    "Más Vendidos": const ZacatrusOrder(
        value: ZacatrusOrderValues.bestSellers, isDesc: true),
    "Más Baratos":
        const ZacatrusOrder(value: ZacatrusOrderValues.price, isDesc: false),
    "Más Nuevos":
        const ZacatrusOrder(value: ZacatrusOrderValues.newest, isDesc: true),
    "Mayor Número de Comentarios": const ZacatrusOrder(
        value: ZacatrusOrderValues.reviewCount, isDesc: true),
    "Mejor Valorados": const ZacatrusOrder(
        value: ZacatrusOrderValues.ratingValue, isDesc: true),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(5.0))),
      child: DropdownButton<String>(
        value: initOrder,
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down),
        underline: Container(),
        onChanged: (String? newOrder) {
          setState(() {
            initOrder = newOrder!;
          });

          ref.read(browserNotifierProvider.notifier).changeFilters(ref
              .read(browserNotifierProvider)
              .urlComposer
              .copyWith(order: Optional.value(categoriesUrl[newOrder])));
        },
        dropdownColor: Colors.grey[200],
        items: categoriesUrl.keys.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
