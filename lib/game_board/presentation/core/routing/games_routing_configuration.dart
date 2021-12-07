import '../../../../core/optional.dart';
import '../../../domain/image_data.dart';
import '../../../zacatrus/domain/url/zacatrus_url_composer.dart';

class GamesRoutingConfiguration {
  bool isSearching = false;
  ZacatrusUrlBrowserComposer? filterComposer;
  bool settings = false;
  bool dice = false;
  String? detailsGameUrl;
  ImageData? imageLoaded;

  GamesRoutingConfiguration.home({
    this.filterComposer,
  })  : settings = false,
        detailsGameUrl = null;

  GamesRoutingConfiguration.details({this.detailsGameUrl})
      : filterComposer = null,
        settings = false;

  GamesRoutingConfiguration.settings() : settings = true;

  GamesRoutingConfiguration.dice() : dice = true;

  // ZacatrusUrlBrowserComposer? get filterComposer => _filterComposer;

  bool isHome() =>
      settings == false && detailsGameUrl == null && imageLoaded == null;

  @override
  String toString() {
    return 'GamesRoutingConfiguration{isSearching: $isSearching, filterComposer: $filterComposer, settings: $settings, dice: $dice, detailsGameUrl: $detailsGameUrl, imageLoaded: $imageLoaded}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GamesRoutingConfiguration &&
          runtimeType == other.runtimeType &&
          isSearching == other.isSearching &&
          filterComposer == other.filterComposer &&
          settings == other.settings &&
          dice == other.dice &&
          detailsGameUrl == other.detailsGameUrl &&
          imageLoaded == other.imageLoaded;

  @override
  int get hashCode =>
      isSearching.hashCode ^
      filterComposer.hashCode ^
      settings.hashCode ^
      dice.hashCode ^
      detailsGameUrl.hashCode ^
      imageLoaded.hashCode;

  GamesRoutingConfiguration copyWith(
      {Optional<ZacatrusUrlBrowserComposer?>? filterComposer,
      bool? settings,
      bool? dice,
      Optional<String?>? detailsGameUrl,
      Optional<ImageData?>? imageLoaded,
      bool? isSearching}) {
    return GamesRoutingConfiguration._(
      filterComposer:
          filterComposer == null ? this.filterComposer : filterComposer.value,
      settings: settings ?? this.settings,
      dice: dice ?? this.dice,
      detailsGameUrl:
          detailsGameUrl == null ? this.detailsGameUrl : detailsGameUrl.value,
      imageLoaded: imageLoaded == null ? this.imageLoaded : imageLoaded.value,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  GamesRoutingConfiguration._(
      {this.filterComposer,
      required this.settings,
      this.dice = false,
      this.detailsGameUrl,
      this.imageLoaded,
      this.isSearching = false});
}
