import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:zacatrusa/constants/app_margins_and_sizes.dart';

import '../../../../zacatrus/domain/details_page/images_carousel.dart';

class ImagesCarouselDisplay extends StatefulWidget {
  const ImagesCarouselDisplay({
    required this.carousel,
    Key? key,
  }) : super(key: key);

  final ImagesCarousel carousel;

  @override
  _ImagesCarouselDisplayState createState() => _ImagesCarouselDisplayState();
}

class _ImagesCarouselDisplayState extends State<ImagesCarouselDisplay> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: const Icon(
            Icons.arrow_back,
            size: mediumIconSize,
            semanticLabel: "Imagen anterior",
          ),
          onTap: () {
            setState(() {
              if (index > 0) {
                index--;
              } else if (index == 0) {
                index = widget.carousel.items.length - 1;
              }
            });
          },
        ),
        Flexible(
          child: ExtendedImage.network(
            widget.carousel.items[index].image,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
        ),
        InkWell(
          child: const Icon(
            Icons.arrow_forward,
            size: mediumIconSize,
            semanticLabel: "Siguiente imagen",
          ),
          onTap: () {
            setState(() {
              index = (index + 1) % widget.carousel.items.length;
            });
          },
        ),
      ],
    );
  }
}
