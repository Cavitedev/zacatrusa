import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagesCarousel extends StatefulWidget {
  ImagesCarousel({
    required this.items,
  });

  List<CarouselItem> items;
  int index = 0;

  CarouselItem get mainItem =>
      items.firstWhere((item) => item.isMain, orElse: () => items.first);

  @override
  State<ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: const Icon(
            Icons.arrow_back,
          ),
          onTap: () {
            setState(() {
              if (index > 0) {
                index--;
              } else if (index == 0) {
                index = widget.items.length - 1;
              }
            });
          },
        ),
        Flexible(
          child: ExtendedImage.network(
            widget.items[index].image,
            clipBehavior: Clip.hardEdge,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
        ),
        InkWell(
          child: const Icon(
            Icons.arrow_forward,
          ),
          onTap: () {
            setState(() {
              index = (index + 1) % widget.items.length;
            });
          },
        ),
      ],
    );
  }
}

class CarouselItem {
  const CarouselItem({
    required this.image,
    required this.semantics,
    this.video,
    required this.isMain,
  });

  final String image;
  final String semantics;
  final String? video;
  final bool isMain;
}
