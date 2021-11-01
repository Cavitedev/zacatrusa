import 'package:zacatrusa/game_board/zacatrus/domain/game_overview.dart';

class ZacatrusBrowsePageData {
  const ZacatrusBrowsePageData({
    this.amount,
    required this.games,
  });

  final int? amount;
  final List<GameOverview> games;
}
