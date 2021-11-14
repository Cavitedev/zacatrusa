import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zacatrusa/constants/app_error_constants.dart';

import '../../../../constants/app_margins_and_sizes.dart';

class ErrorWidgetWithImage extends StatelessWidget {
  const ErrorWidgetWithImage({
    Key? key,
    required this.msg,
    required this.image,
  }) : super(key: key);

  final String msg;
  final String image;

  @override
  Widget build(BuildContext context) {
    final TextStyle errorStyle = AppErrorConstants.errorTextStyle(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: listPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: listSpacing,
          ),
          Text(
            msg,
            softWrap: true,
            style: errorStyle,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: listSpacing),
            child: SvgPicture.asset(
              image,
              height: 300,
              alignment: Alignment.topCenter,
            ),
          ),
        ],
      ),
    );
  }
}
