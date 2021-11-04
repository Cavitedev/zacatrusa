import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zacatrusa/core/multiple_result.dart';
import 'package:zacatrusa/game_board/infrastructure/core/internet_feedback.dart';
import 'package:zacatrusa/game_board/zacatrus/application/browser/zacatrus_browser_notifier.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/game_overview.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/zacatrus_url_composer.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/zacatrus_browse_page_data.dart';
import 'package:zacatrusa/game_board/zacatrus/infrastructure/zacatrus_scrapper.dart';

class MockZacatrusScrapper extends Mock implements ZacatrusScapper {}

void main() {
  late ZacatrusScapper scrapper;

  late ZacatrusBrowserNotifier notifier;

  setUp(() {
    scrapper = MockZacatrusScrapper();
  });

  group("loadGames", () {
    test("Loading next page 2 times in no time returns the first page ",
        () async {
      _mockScrapper(scrapper);

      notifier = ZacatrusBrowserNotifier(scrapper: scrapper);
      notifier.nextPageIfNotLoading();
      notifier.nextPageIfNotLoading();
      await Future.delayed(const Duration(milliseconds: 400));

      expect(notifier.state.games, [gameOverview1]);
    });

    test(
        "Loading next page 2 times with the duration interval right for the last call, returns two first pages",
        () async {
      _mockScrapper(scrapper);

      notifier = ZacatrusBrowserNotifier(scrapper: scrapper);
      notifier.nextPageIfNotLoading();
      await Future.delayed(const Duration(milliseconds: 200));
      notifier.nextPageIfNotLoading();
      await Future.delayed(const Duration(milliseconds: 200));

      expect(notifier.state.games, [gameOverview1, gameOverview2]);
    });

    test("Loading next page when first retrieves error retries first one",
        () async {
      ZacatrusUrlBrowserComposer urlComposer1 =
          ZacatrusUrlBrowserComposer.init();

      final List<
          Stream<Either<InternetFeedback, ZacatrusBrowsePageData>> Function(
              Invocation)> answers = [
        (_) => Stream.fromFutures(
            [Future.value(Left(NoInternetFailure(url: "url")))]),
        (_) => Stream.fromFutures([
              Future.value(
                  Right(ZacatrusBrowsePageData(games: [gameOverview1])))
            ]),
      ];

      when(() => scrapper.getGamesOverviews(urlComposer1))
          .thenAnswer((invocation) => answers.removeAt(0)(invocation));

      ZacatrusUrlBrowserComposer urlComposer2 = urlComposer1.nextPage();
      _mockScrapperSingleCall(scrapper, urlComposer2, gameOverview2);

      notifier = ZacatrusBrowserNotifier(scrapper: scrapper);
      notifier.loadGames();
      await Future.delayed(const Duration(milliseconds: 200));
      notifier.nextPageIfNotLoading();
      await Future.delayed(const Duration(milliseconds: 200));

      expect(notifier.state.games, [gameOverview1]);
    });
  });
}

final GameOverview gameOverview1 = GameOverview(name: "Game1");
final GameOverview gameOverview2 = GameOverview(name: "Game2");
final GameOverview gameOverview3 = GameOverview(name: "Game3");

void _mockScrapper(ZacatrusScapper scrapper) {
  ZacatrusUrlBrowserComposer urlComposer1 = ZacatrusUrlBrowserComposer.init();
  _mockScrapperSingleCall(scrapper, urlComposer1, gameOverview1);

  ZacatrusUrlBrowserComposer urlComposer2 = urlComposer1.nextPage();
  _mockScrapperSingleCall(scrapper, urlComposer2, gameOverview2);

  ZacatrusUrlBrowserComposer urlComposer3 = urlComposer2.nextPage();
  _mockScrapperSingleCall(scrapper, urlComposer3, gameOverview3);
}

void _mockScrapperSingleCall(ZacatrusScapper scrapper,
    ZacatrusUrlBrowserComposer urlComposer, GameOverview gameOverview) {
  when(() => scrapper.getGamesOverviews(urlComposer))
      .thenAnswer((invocation) => Stream.fromFutures([
            Future.value(Left(InternetLoading(url: urlComposer.buildUrl()))),
            Future.delayed(const Duration(milliseconds: 100),
                () => Right(ZacatrusBrowsePageData(games: [gameOverview])))
          ]));
}
