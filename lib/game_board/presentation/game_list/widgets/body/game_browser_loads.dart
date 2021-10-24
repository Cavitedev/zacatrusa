import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/presentation/core/feedback_errors_loading/internet_feedback_widgets.dart';
import 'package:zacatrusa/game_board/zacatrus/application/browser/zacatrus_browser_notifier.dart';

class GameBrowserLoads extends ConsumerWidget {
  const GameBrowserLoads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, _) {
        final feedback =
            ref.watch(zacatrusBrowserNotifierProvider).loadingFeedback;

        if (feedback != null) {
          return SliverToBoxAdapter(
              child: InternetFeedbackWidget(feedback: feedback));
        } else {
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }
      },
    );
  }
}
