import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_margins_and_sizes.dart';
import '../../application/details/details_notifier.dart';
import '../../zacatrus/domain/details_page/zacatrus_details_page_data.dart';
import '../core/feedback_errors_loading/internet_feedback_widgets.dart';
import 'states/success/game_details_success.dart';

class GameDetails extends ConsumerWidget {
  const GameDetails({
    required this.url,
    Key? key,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = ref.watch(detailsNotifierProvider(url));
    final eitherData = detailsState.data;

    if (eitherData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Detalles del Juego")),
      );
    }

    if (eitherData.isLeft()) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Detalles del Juego"),
            leading: Semantics(
              value: "Volver atrás",
              child: BackButton(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(generalPadding),
            child: InternetFeedbackWidget(feedback: eitherData.getLeft()!),
          ));
    } else {
      final ZacatrusDetailsPageData data = eitherData.getRight()!;

      return GameDetailsSuccess(data: data);
    }
  }
}
