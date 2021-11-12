class ImagesCarousel {
  ImagesCarousel({
    required this.items,
  });
  List<CarouselItem> items;

  CarouselItem get mainItem =>
      items.firstWhere((item) => item.isMain, orElse: () => items.first);
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
