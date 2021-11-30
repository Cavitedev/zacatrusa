import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
          itemSize: 25.0,
        ),
      ),
    );
  }
}
