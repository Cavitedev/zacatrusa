import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zacatrusa/core/optional.dart';
import 'package:zacatrusa/game_board/presentation/core/routing/games_router_delegate.dart';

import '../../../../../constants/app_margins_and_sizes.dart';
import '../../../../zacatrus/domain/details_page/images_carousel.dart';

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
  int index = 0;
  bool canSwipe = true;
  late final ExtendedPageController carouselController;

  static const swipeDuration = Duration(milliseconds: 300);
  static const swipeCurve = Curves.easeInOutCirc;

  @override
  void initState() {
    super.initState();
    carouselController = ExtendedPageController(
      initialPage: 0,
      pageSpacing: 50,
    );
  }

  @override
  void dispose() {
    super.dispose();
    carouselController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double imageHeight = MediaQuery.of(context).size.height * 0.3;
    return Row(
      children: [
        InkWell(
          child: SizedBox(
            height: imageHeight,
            child: const Icon(
              Icons.arrow_back,
              size: mediumIconSize,
              semanticLabel: "Imagen anterior",
            ),
          ),
          onTap: () {
            late int nextIndex;
            if (index > 0) {
              nextIndex = index - 1;
            } else if (index == 0) {
              nextIndex = widget.carousel.items.length - 1;
            }

            carouselController.animateToPage(nextIndex,
                duration: swipeDuration, curve: swipeCurve);
          },
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: imageHeight,
            child: ExtendedImageGesturePageView.builder(
              // key: ValueKey(widget.carousel.hashCode),
              physics: const BouncingScrollPhysics(),
              itemCount: widget.carousel.items.length,
              controller: carouselController,
              canScrollPage: (GestureDetails? gesture) {
                return false;
              },
              onPageChanged: (newPage) {
                setState(() {
                  index = newPage;
                });
              },
              itemBuilder: (context, index) {
                final item = widget.carousel.items[index];
                return GestureDetector(
                  child: Hero(
                    tag: item.image,
                    child: Stack(
                      children: [
                        ExtendedImage.network(
                          item.image,
                          key: ValueKey(item.image),
                          width: double.infinity,
                          height: imageHeight,
                          mode: ExtendedImageMode.gesture,
                        ),
                        if (item.video != null)
                          const Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.play_circle,
                              size: 72,
                              semanticLabel: "Reproducir vídeo",
                            ),
                          ))
                      ],
                    ),
                  ),
                  onTap: () {
                    canSwipe = false;
                    if (item.video != null) {
                      launch(item.video!);
                      return;
                    }

                    final router = ref.read(gamesRouterDelegateProvider);
                    router.currentConf = router.currentConf
                        .copyWith(imageLoaded: Optional.value(item.image));
                  },
                );
              },
            ),
          ),
        ),
        InkWell(
          child: SizedBox(
            height: imageHeight,
            child: const Icon(
              Icons.arrow_forward,
              size: mediumIconSize,
              semanticLabel: "Siguiente imagen",
            ),
          ),
          onTap: () {
            carouselController.animateToPage(
                (index + 1) % widget.carousel.items.length,
                duration: swipeDuration,
                curve: swipeCurve);
          },
        ),
      ],
    );
  }
}
