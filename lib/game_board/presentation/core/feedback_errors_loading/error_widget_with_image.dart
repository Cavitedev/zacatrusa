import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/app_margins.dart';

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
    final TextStyle errorStyle = Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(color: Theme.of(context).errorColor);

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
