import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:zacatrusa/core/multiple_result.dart';
import 'package:zacatrusa/game_board/infrastructure/core/internet_feedback.dart';
import 'package:zacatrusa/game_board/infrastructure/http_loader.dart';

class MockClient extends Mock implements http.Client {}

class MockProviderRef extends Mock implements ProviderRef {}

class MockConnectivity extends Mock implements Connectivity {}

const String pageContent = "Page content";
const String url = "https://loads_page";
MockClient mockClient = MockClient();

void main() {
  final dom.Document fakeDom = parser.parse(pageContent);

  MockConnectivity mockConnectivity = MockConnectivity();
  MockProviderRef mockProviderRef = MockProviderRef();

  const SocketException noInternetSocketException = SocketException(
      "Failed host lookup: $url",
      osError: OSError("No address associated with hostname", 7));

  setUp(() {
    mockConnectivity = MockConnectivity();
    mockProviderRef = MockProviderRef();
    mockClient = MockClient();
    when(() => mockProviderRef.read(connectivityProvider))
        .thenReturn(mockConnectivity);
  });

  group("getPage", () {
    test("Loading right page works fine", () {
      // Arrange

      _onMockClientGet(statusCode: 200);

      final HttpLoader httpLoader =
          HttpLoader(ref: mockProviderRef, client: mockClient);

      // Act
      final docStream = httpLoader.getPage(url: url);

      // Assert
      expect(
          _streamDocumentToString(docStream),
          emits(
            fakeDom.outerHtml,
          ));
    });

    test(
        "Loading page with SocketException and connectivity return Error(noInternetFailure)",
        () {
      // Arrange
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) => Future.value(ConnectivityResult.wifi));

      when(() => mockClient.get(Uri.parse(url))).thenThrow(
        noInternetSocketException,
      );
      final HttpLoader httpLoader =
          HttpLoader(ref: mockProviderRef, client: mockClient);

      // Act
      final docStream = httpLoader.getPage(url: url);

      // Assert
      expect(
          docStream,
          emits(
            Left(NoInternetFailure(url: url)),
          ));
    });

    test("Calling get with error code 404 returns StatusCodeFailure", () {
      // Arrange
      const int statusCode = 404;

      when(() => mockClient.get(Uri.parse(url))).thenAnswer(
        (_) => Future.value(http.Response(pageContent, statusCode)),
      );

      final HttpLoader httpLoader =
          HttpLoader(ref: mockProviderRef, client: mockClient);

      // Act
      final docStream = httpLoader.getPage(url: url);

      // Assert
      expect(
          docStream,
          emitsInOrder([
            Left(StatusCodeInternetFailure(url: url, statusCode: statusCode)),
            emitsDone
          ]));
    });

    test("Retrying get with error code 404 returns StatusCodeFailure", () {
      // Arrange
      const int statusCode = 404;

      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) => Future.value(ConnectivityResult.none));

      when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) async* {
        yield ConnectivityResult.wifi;
      });

      final List<Future<http.Response> Function(Invocation)> answers = [
        (_) => throw noInternetSocketException,
        (_) => Future.value(http.Response(pageContent, statusCode))
      ];

      when(() => mockClient.get(Uri.parse(url))).thenAnswer(
        (_) => answers.removeAt(0)(_),
      );

      final HttpLoader httpLoader =
          HttpLoader(ref: mockProviderRef, client: mockClient);

      // Act
      final docStream = httpLoader.getPage(url: url);

      // Assert
      expect(
          docStream,
          emitsInOrder([
            Left(NoInternetRetryFailure(url: url)),
            Left(InternetLoading(url: url)),
            Left(StatusCodeInternetFailure(url: url, statusCode: statusCode)),
            emitsDone
          ]));
    });

    test(
        "Loading page with SocketException and none connectivity streams Error(noInternetRetryFailure), on reconnect with internet loads it",
        () {
      // Arrange
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) => Future.value(ConnectivityResult.none));

      when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) async* {
        yield ConnectivityResult.wifi;
      });

      final List<Future<http.Response> Function(Invocation)> answers = [
        (_) => throw noInternetSocketException,
        (_) => Future.delayed(
              const Duration(milliseconds: 20),
              () => Future.value(http.Response(pageContent, 200)),
            )
      ];

      when(() => mockClient.get(Uri.parse(url)))
          .thenAnswer((_) => answers.removeAt(0)(_));

      final HttpLoader httpLoader =
          HttpLoader(ref: mockProviderRef, client: mockClient);

      // Act
      final docStream = httpLoader.getPage(url: url);

      // Assert
      expect(
          _streamDocumentToString(docStream),
          emitsInOrder([
            Left(NoInternetRetryFailure(url: url)),
            Left(InternetLoading(url: url)),
            fakeDom.outerHtml,
            emitsDone
          ]));
    });

    test(
        "Loading page with SocketException and none connectivity streams Error(noInternetRetryFailure), on reconnect without internet fails again",
        () {
      // Arrange
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) => Future.value(ConnectivityResult.none));

      when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) async* {
        yield ConnectivityResult.wifi;
      });

      when(() => mockClient.get(Uri.parse(url))).thenThrow(
        noInternetSocketException,
      );
      final HttpLoader httpLoader =
          HttpLoader(ref: mockProviderRef, client: mockClient);

      // Act
      final docStream = httpLoader.getPage(url: url);

      // Assert
      expect(
          docStream,
          emitsInOrder([
            Left(NoInternetRetryFailure(url: url)),
            Left(InternetLoading(url: url)),
            Left(NoInternetFailure(url: url)),
            emitsDone
          ]));
    });
  });
}

Stream<Object> _streamDocumentToString(
    Stream<Either<InternetFeedback, dom.Document>> docStream) {
  return docStream.map((result) {
    if (result.isRight()) {
      return (result.get() as dom.Document).outerHtml;
    } else {
      return result;
    }
  });
}

void _onMockClientGet({
  required int statusCode,
}) {
  when(() => mockClient.get(Uri.parse(url))).thenAnswer((_) => Future.delayed(
        const Duration(milliseconds: 20),
        () => Future.value(http.Response(pageContent, statusCode)),
      ));
}
