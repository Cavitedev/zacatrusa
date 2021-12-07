import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_framework/responsive_framework.dart';

class StarsBarIndicator extends StatelessWidget {
  const StarsBarIndicator({
    Key? key,
    required this.stars,
  }) : super(key: key);

  final double stars;

  @override
  Widget build(BuildContext context) {
    return Semantics.fromProperties(
      properties: SemanticsProperties(
          label: "$stars ${stars == 1 ? "estrella" : "estrellas"}"),
      child: ExcludeSemantics(
        child: RatingBarIndicator(
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          rating: stars,
          itemSize: ResponsiveValue<double>(context,
              defaultValue:
                  min(24.0, 24.0 * MediaQuery.textScaleFactorOf(context)),
              valueWhen: [
                Condition.largerThan(
                    name: MOBILE,
                    value: min(
                        36.0, 24.0 * MediaQuery.textScaleFactorOf(context))),
                 Condition.largerThan(
                    name: PHONE,
                    value: 24.0 * MediaQuery.textScaleFactorOf(context)),
              ]).value!,
        ),
      ),
    );
  }
}
