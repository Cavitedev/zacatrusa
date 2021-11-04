import '../../../zacatrus/domain/url/zacatrus_url_composer.dart';

class GamesRoutingConfiguration {
  ZacatrusUrlBrowserComposer? filterComposer;
  bool settings;
  String? detailsGame;

  GamesRoutingConfiguration.home({
    this.filterComposer,
  })  : settings = false,
        detailsGame = null;

  GamesRoutingConfiguration.details({this.detailsGame})
      : filterComposer = null,
        settings = false;

  GamesRoutingConfiguration.settings() : settings = true;

  // ZacatrusUrlBrowserComposer? get filterComposer => _filterComposer;

  bool isHome() => settings == false && detailsGame == null;


  @override
  String toString() {
    return 'GamesRoutingConfiguration{filterComposer: $filterComposer, settings: $settings, detailsGame: $detailsGame}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GamesRoutingConfiguration &&
          runtimeType == other.runtimeType &&
          filterComposer == other.filterComposer &&
          settings == other.settings &&
          detailsGame == other.detailsGame;

  @override
  int get hashCode =>
      filterComposer.hashCode ^ settings.hashCode ^ detailsGame.hashCode;
}
