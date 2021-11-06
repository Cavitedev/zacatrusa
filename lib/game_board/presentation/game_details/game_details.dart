import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_margins.dart';

import '../../application/details/details_notifier.dart';
import '../../zacatrus/domain/details_page/zacatrus_details_page_data.dart';
import '../core/feedback_errors_loading/internet_feedback_widgets.dart';

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
        appBar: AppBar(title: const Text("Game Details")),
      );
    }

    if (eitherData.isLeft()) {
      return Scaffold(
          appBar: AppBar(title: const Text("Game Details")),
          body: Padding(
            padding: const EdgeInsets.all(generalPadding),
            child: InternetFeedbackWidget(feedback: eitherData.getLeft()!),
          ));
    } else {
      final ZacatrusDetailsPageData data = eitherData.getRight()!;

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(data.gameOverview.name),
            )
          ],

        ),
      );
    }
  }
}
