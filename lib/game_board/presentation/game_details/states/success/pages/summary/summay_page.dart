import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({required this.overviewDescription, Key? key})
      : super(key: key);

  final String overviewDescription;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: SelectableText(
      overviewDescription,
    ));
  }
}
