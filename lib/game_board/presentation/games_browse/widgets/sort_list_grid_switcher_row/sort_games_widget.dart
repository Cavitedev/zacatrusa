import 'package:flutter/material.dart';

class SortGamesWidget extends StatefulWidget {
  const SortGamesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SortGamesWidget> createState() => _SortGamesWidget();
}

class _SortGamesWidget extends State<SortGamesWidget> {
  String initOrder = 'Más vendidos';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(5.0))),
      height: 35,
      child: DropdownButton<String>(
          value: initOrder,
          icon: const Icon(Icons.arrow_drop_down),
          underline: Container(),
          onChanged: (String? newOrder) {
            setState(() {
              initOrder = newOrder!;
            });
          },
          dropdownColor: Colors.grey[200],
          items: <String>[
            'Más vendidos',
            'Precio',
            'Nuevo',
            'Número de comentarios',
            'Mejor valorados'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(value),
              ),
            );
          }).toList()),
    );
  }
}
