import 'package:flutter/material.dart';

import '../../../../constants/app_margins_and_sizes.dart';

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({
    required this.errorMsg,
    Key? key,
  }) : super(key: key);

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: generalBorderRadius,
      ),
      child: SelectableText(
        errorMsg,
      ),
    );
  }
}
