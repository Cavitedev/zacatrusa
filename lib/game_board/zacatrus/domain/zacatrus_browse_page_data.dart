import 'game_overview.dart';

class ZacatrusBrowsePageData {
  const ZacatrusBrowsePageData({
    required this.games,
    this.amount,
  });

  final int? amount;
  final List<GameOverview> games;
}
