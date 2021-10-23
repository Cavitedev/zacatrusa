import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:zacatrusa/game_board/infrastructure/core/connectivity_helper.dart';
import 'package:zacatrusa/game_board/infrastructure/core/internet_feedback.dart';

final Provider<Connectivity> connectivityProvider =
    Provider<Connectivity>((_) => Connectivity());

final httpLoaderProvider = Provider((ref) {
  final loader = HttpLoader(ref: ref, client: RetryClient(http.Client()));
  ref.onDispose(() {
    loader.client.close();
  });
  return loader;
});

class HttpLoader {
  HttpLoader({
    required this.ref,
    required this.client,
  });

  final ProviderRef ref;
  final http.Client client;

  void onDispose() {
    client.close();
  }

  Stream<Result<InternetFeedback, dom.Document>> getPage({
    required String url,
  }) async* {
    try {
      http.Response response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        yield Success(_decodeResponse(response));
      } else {
        yield Error(StatusCodeInternetFailure(
            url: url, statusCode: response.statusCode));
      }
    } on SocketException {
      final Connectivity connectivity = ref.read(connectivityProvider);
      final ConnectivityResult connectivityResult =
          await connectivity.checkConnectivity();

      if (connectivityResult != ConnectivityResult.none) {
        yield Error(NoInternetFailure(url: url));
      } else {
        yield* _retryWhenConnected(url, connectivity);
      }
    }
  }

  Stream<Result<InternetFeedback, dom.Document>> _retryWhenConnected(
      String url, Connectivity connectivity) async* {
    yield Error(NoInternetRetryFailure(url: url));

    try {
      await connectivity.onConnectionFound();
      yield Error(InternetLoading(url: url));

      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        yield Success(_decodeResponse(response));
      } else {
        yield Error(StatusCodeInternetFailure(
            url: url, statusCode: response.statusCode));
      }
    } on SocketException {
      yield Error(NoInternetFailure(url: url));
    }
  }

  dom.Document _decodeResponse(http.Response response) {
    final String body = utf8.decode(response.bodyBytes);
    final dom.Document document = parser.parse(body);
    return document;
  }
}
