import 'package:zacatrusa/game_board/zacatrus/domain/game_overview.dart';

import 'filters/zacatrus_filters.dart';

class ZacatrusBrowsePageData {
  const ZacatrusBrowsePageData({
    required this.games,
    this.filters,
    this.amount,
  });

  final int? amount;
  final List<GameOverview> games;
  final ZacatrusFilters? filters;
}
