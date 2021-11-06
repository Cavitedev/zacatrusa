import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../core/multiple_result.dart';
import 'core/connectivity_helper.dart';
import 'core/internet_feedback.dart';

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

  Stream<Either<InternetFeedback, dom.Document>> getPage({
    required String url,
  }) async* {
    yield Left(InternetLoading(url: url));

    try {
      http.Response response = await client.get(Uri.parse(url), headers: {"accept-encoding": "gzip, deflate, br"});
      if (response.statusCode == 200) {
        yield Right(_decodeResponse(response));
      } else {
        yield Left(StatusCodeInternetFailure(
            url: url, statusCode: response.statusCode));
      }
    } on SocketException {
      final Connectivity connectivity = ref.read(connectivityProvider);
      final ConnectivityResult connectivityResult =
          await connectivity.checkConnectivity();

      if (connectivityResult != ConnectivityResult.none) {
        yield Left(NoInternetFailure(url: url));
      } else {
        yield* _retryWhenConnected(url, connectivity);
      }
    }
  }

  Stream<Either<InternetFeedback, dom.Document>> _retryWhenConnected(
      String url, Connectivity connectivity) async* {
    yield Left(NoInternetRetryFailure(url: url));

    try {
      await connectivity.onConnectionFound();
      yield Left(InternetReloading(url: url));

      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        yield Right(_decodeResponse(response));
      } else {
        yield Left(StatusCodeInternetFailure(
            url: url, statusCode: response.statusCode));
      }
    } on SocketException {
      yield Left(NoInternetFailure(url: url));
    }
  }

  dom.Document _decodeResponse(http.Response response) {
    final String body = utf8.decode(response.bodyBytes);
    final dom.Document document = parser.parse(body);
    return document;
  }
}
