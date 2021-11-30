import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../constants/app_margins_and_sizes.dart';
import '../../../../../core/optional.dart';
import '../../../../domain/image_data.dart';
import '../../../../zacatrus/domain/details_page/images_carousel.dart';
import '../../../core/routing/games_router_delegate.dart';

class ImagesCarouselDisplay extends ConsumerStatefulWidget {
  const ImagesCarouselDisplay({
    required this.carousel,
    Key? key,
  }) : super(key: key);

  final ImagesCarousel carousel;

  @override
  _ImagesCarouselDisplayState createState() => _ImagesCarouselDisplayState();
}

class _ImagesCarouselDisplayState extends ConsumerState<ImagesCarouselDisplay> {
  late final CarouselController carouselController;

  static const swipeDuration = Duration(milliseconds: 300);
  static const swipeCurve = Curves.easeInOutCirc;

  @override
  void initState() {
    super.initState();
    carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double imageHeight =
        min(screenSize.height * 0.5, (screenSize.width - 100) / (16 / 9));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: generalPadding),
      child: SizedBox(
        height: imageHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: const SizedBox(
                height: double.infinity,
                child: Icon(
                  Icons.arrow_back,
                  size: mediumIconSize,
                  semanticLabel: "Imagen anterior",
                ),
              ),
              onTap: () {
                carouselController.previousPage(
                    duration: swipeDuration, curve: swipeCurve);
              },
            ),
            Expanded(
              child: CarouselSlider.builder(
                itemCount: widget.carousel.items.length,
                carouselController: carouselController,
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  initialPage: widget.carousel.indexOfMainItem,
                ),
                itemBuilder: (context, itemIndex, pageViewIndex) {
                  final item = widget.carousel.items[itemIndex];
                  return GestureDetector(
                    child: ImageOfCarousel(item: item),
                    onTap: () {
                      if (item.video != null) {
                        launch(item.video!);
                        return;
                      }

                      final router = ref.read(gamesRouterDelegateProvider);
                      router.currentConf = router.currentConf.copyWith(
                          imageLoaded: Optional.value(ImageData(
                              imageLink: item.image,
                              imageAlt: item.semantics)));
                    },
                  );
                },
              ),
            ),
            InkWell(
              child: const SizedBox(
                height: double.infinity,
                child: Icon(
                  Icons.arrow_forward,
                  size: mediumIconSize,
                  semanticLabel: "Siguiente imagen",
                ),
              ),
              onTap: () {
                carouselController.nextPage(
                    duration: swipeDuration, curve: swipeCurve);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ImageOfCarousel extends StatelessWidget {
  const ImageOfCarousel({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CarouselItem item;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: item.image,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          child: Stack(
            children: [
              ExtendedImage.network(
                item.image,
                key: ValueKey(item.image),
                semanticLabel: item.semantics,
              ),
              if (item.video != null)
                const Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle,
                    size: 72,
                    semanticLabel: "Reproducir vídeo explícando el juego",
                  ),
                ))
            ],
          ),
        ),
      ),
    );
  }
}
