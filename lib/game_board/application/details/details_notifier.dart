import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../zacatrus/infrastructure/zacatrus_details_page_scrapper.dart';
import 'details_state.dart';

final detailsNotifierProvider =
    StateNotifierProvider.family<DetailsNotifier, DetailsState, String>(
  (ref, url) =>
      DetailsNotifier(ref.read(zacatrusDetailsPageScrapperProvider), url),
);

class DetailsNotifier extends StateNotifier<DetailsState> {
  DetailsNotifier(this.scrapper, this.url) : super(const DetailsState()) {
    loadData();
  }

  final ZacatrusDetailsPageScapper scrapper;
  final String url;

  StreamSubscription? subscription;

  void loadData() {
    subscription?.cancel();
    subscription = scrapper.getGameDetails(url).listen((event) {
      state = state.copyWith(data: event);
    })
      ..onDone(() {
        subscription = null;
      });
  }
}
