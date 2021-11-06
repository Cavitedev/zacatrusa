import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/details_page/zacatrus_details_page_data.dart';
import 'package:zacatrusa/game_board/zacatrus/infrastructure/zacatrus_details_page_scrapper.dart';

void main() {
  ProviderContainer container = ProviderContainer();

  setUp(() {
    container = ProviderContainer();
  });

  group("Scrap details page", () {
    test("Scrap first game Unánimo", () async {
      final ZacatrusDetailsPageScapper scrapper =
          container.read(zacatrusDetailsPageScrapperProvider);

      final httpCall =
          scrapper.getGameDetails("https://zacatrus.es/unanimo.html");

      final result = await httpCall.skip(1).first;

      expect(result.isRight(), isTrue);

      final ZacatrusDetailsPageData data = result.getRight()!;
    });
  });
}
