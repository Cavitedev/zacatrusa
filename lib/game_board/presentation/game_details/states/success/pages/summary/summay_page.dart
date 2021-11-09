import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ExtendedImage.network(
            "https://media.zacatrus.es/catalog/product/cache/f22f70ef8ee260256901b557cf6bf49a/a/l/alhambra2020_pinta.jpg",
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
