import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'hero_widget.dart';

class SlidePage extends StatefulWidget {
  const SlidePage({this.url, this.semantics, Key? key}) : super(key: key);
  final String? url;
  final String? semantics;

  @override
  _SlidePageState createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  GlobalKey<ExtendedImageSlidePageState> slidePagekey =
      GlobalKey<ExtendedImageSlidePageState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ExtendedImageSlidePage(
        key: slidePagekey,
        child: GestureDetector(
          child: widget.url == 'This is an video'
              ? ExtendedImageSlidePageHandler(
                  child: Material(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.yellow,
                      child: const Text('This is an video'),
                    ),
                  ),

                  ///make hero better when slide out
                  heroBuilderForSlidingPage: (Widget result) {
                    return Hero(
                      tag: widget.url!,
                      child: result,
                      flightShuttleBuilder: (BuildContext flightContext,
                          Animation<double> animation,
                          HeroFlightDirection flightDirection,
                          BuildContext fromHeroContext,
                          BuildContext toHeroContext) {
                        final Hero hero =
                            (flightDirection == HeroFlightDirection.pop
                                ? fromHeroContext.widget
                                : toHeroContext.widget) as Hero;

                        return hero.child;
                      },
                    );
                  },
                )
              : HeroWidget(
                  child: Semantics(
                    value: "Imagen ampliada ${widget.semantics}",
                    onTapHint: "Volver a la vista normal",
                    onTap: () {
                      slidePagekey.currentState!.popPage();
                      Navigator.pop(context);
                    },
                    child: ExtendedImage.network(
                      widget.url!,
                      enableSlideOutPage: true,
                    ),
                  ),
                  tag: widget.url!,
                  slideType: SlideType.onlyImage,
                  slidePagekey: slidePagekey,
                ),
          onTap: () {
            slidePagekey.currentState!.popPage();
            Navigator.pop(context);
          },
        ),
        slideAxis: SlideAxis.both,
        slideType: SlideType.onlyImage,
      ),
    );
  }
}
