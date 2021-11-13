import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/app_margins_and_sizes.dart';
import '../../../../application/browser/browser_notifier.dart';
import '../../../core/feedback_errors_loading/internet_feedback_widgets.dart';

class GamesBrowserLoads extends ConsumerWidget {
  const GamesBrowserLoads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, _) {
        final feedback = ref.watch(browserNotifierProvider).loadingFeedback;

        if (feedback != null) {
          return SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(generalPadding),
            child: InternetFeedbackWidget(feedback: feedback),
          ));
        } else {
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }
      },
    );
  }
}
