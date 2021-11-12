class ImagesCarousel {
  ImagesCarousel({
    required this.items,
  });
  List<CarouselItem> items;

  int get indexOfMainItem {
    int mainIndex = items.indexWhere((item) => item.isMain);
    if (mainIndex == -1) {
      return 0;
    }
    return mainIndex;
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
