import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  const PriceText({
    required this.price,
    Key? key,
  }) : super(key: key);

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text(
      price.toStringAsFixed(2) + " €",
      style: Theme.of(context)
          .textTheme
          .subtitle2!
          .copyWith(fontWeight: FontWeight.w600),
    );
  }
}
