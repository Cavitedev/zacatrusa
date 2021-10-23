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

class MockWidgetRef extends Mock implements ProviderRef {}

class MockConnectivity extends Mock implements Connectivity {}

const String pageContent = "Page content";
const String url = "https://loads_page";
MockClient mockClient = MockClient();

void main() {
  final dom.Document fakeDom = parser.parse(pageContent);

  MockConnectivity mockConnectivity = MockConnectivity();
  MockWidgetRef mockWidgetRef = MockWidgetRef();

  const SocketException noInternetSocketException = SocketException(
      "Failed host lookup: $url",
      osError: OSError("No address associated with hostname", 7));

  setUp(() {
    mockConnectivity = MockConnectivity();
    mockWidgetRef = MockWidgetRef();
    mockClient = MockClient();
    when(() => mockWidgetRef.read(connectivityProvider))
        .thenReturn(mockConnectivity);
  });

  group("getPage", () {
    test("Loading right page works fine", () {
      // Arrange

      _onMockClientGet(statusCode: 200);

      final HttpLoader httpLoader =
          HttpLoader(ref: mockWidgetRef, client: mockClient);

      // Act
      final docStream = httpLoader.getPage(url: url);

      // Assert
      expect(docStream.map((result) {
        if (result.isRight()) {
          return (result.get() as dom.Document).outerHtml;
        } else {
          return result;
        }
      }),
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
          HttpLoader(ref: mockWidgetRef, client: mockClient);

      // Act
      final docStream = httpLoader.getPage(url: url);

      // Assert
      expect(
          docStream,
          emits(
            Left(NoInternetFailure(url: url)),
          ));
    });
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
