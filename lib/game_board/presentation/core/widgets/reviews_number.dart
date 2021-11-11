import 'package:flutter/material.dart';

class ReviewsNumber extends StatelessWidget {
  const ReviewsNumber({
    Key? key,
    required this.numberReviews,
  }) : super(key: key);

  final int numberReviews;

  @override
  Widget build(BuildContext context) {
    return Text(
      numberReviews.toString() +
          (numberReviews > 1 ? " comentarios" : " comentario"),
      style: Theme.of(context).textTheme.caption,
    );
  }
}
