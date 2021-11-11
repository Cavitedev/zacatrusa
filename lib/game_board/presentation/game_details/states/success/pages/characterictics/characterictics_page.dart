import 'package:flutter/material.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/details_page/game_data_sheet.dart';

class CharactericticsPage extends StatelessWidget {
  const CharactericticsPage({required this.gameDataSheet, Key? key})
      : super(key: key);

  final GameDataSheet gameDataSheet;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FixedColumnWidth(120),
      },
      children: [
        if (gameDataSheet.authors != null)
          _rowOfTable("Autor", gameDataSheet.authors!),
        if (gameDataSheet.bgg != null)
          _rowOfTable("BGG", gameDataSheet.bgg!.toString()),
        if (gameDataSheet.mechanic != null)
          _rowOfTable("Mecánica", gameDataSheet.mechanic!.toString()),
        if (gameDataSheet.theme != null)
          _rowOfTable("Temática", gameDataSheet.theme!.toString()),
        if (gameDataSheet.siBuscas != null)
          _rowOfTable("Si buscas...", gameDataSheet.siBuscas!.toString()),
        if (gameDataSheet.ageRanges != null)
          _rowOfTable("Edad", gameDataSheet.ageRanges!.toString()),
        if (gameDataSheet.gameplayDuration != null)
          _rowOfTable(
              "Tiempo de juego", gameDataSheet.gameplayDuration!.toString()),
        if (gameDataSheet.measurements != null)
          _rowOfTable("Medidas", gameDataSheet.measurements!.toString()),
        if (gameDataSheet.complexity != null)
          _rowOfTable("Complejidad", gameDataSheet.complexity!.toString()),
        if (gameDataSheet.editorial != null)
          _rowOfTable("Editorial", gameDataSheet.editorial!.toString()),
        if (gameDataSheet.content != null)
          _rowOfTable("Contenido", gameDataSheet.content!.toString()),
        if (gameDataSheet.language != null)
          _rowOfTable("Idioma", gameDataSheet.language!.toString()),
        if (gameDataSheet.languageDependency != null)
          _rowOfTable("Dependencia del idioma",
              gameDataSheet.languageDependency!.toString()),
      ],
    );
  }

  TableRow _rowOfTable(String label, String data) {
    return TableRow(
      children: [TableLabelText(label), TableDataText(data)],
    );
  }
}

class TableLabelText extends StatelessWidget {
  const TableLabelText(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}

class TableDataText extends StatelessWidget {
  const TableDataText(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }
}
