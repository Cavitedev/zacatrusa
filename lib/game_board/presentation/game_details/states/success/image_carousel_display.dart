import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  Widget build(BuildContext context) {
    var item = widget.carousel.items[index];
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
          child: GestureDetector(
            child: Hero(
              tag: item.image,
              child: ExtendedImage.network(
                item.image,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            onTap: () {
              final router = ref.read(gamesRouterDelegateProvider);
              router.currentConf = router.currentConf
                  .copyWith(imageLoaded: Optional.value(item.image));
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => SlidePage(url: item.image)));
            },
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
