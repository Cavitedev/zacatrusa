import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:zacatrusa/game_board/infrastructure/core/connectivity_helper.dart';
import 'package:zacatrusa/game_board/infrastructure/core/dio_helper.dart';
import 'package:zacatrusa/game_board/infrastructure/core/internet_feedback.dart';

final Provider<Dio> dioProvider = Provider<Dio>((_) => Dio());
final Provider<Connectivity> connectivityProvider =
    Provider<Connectivity>((_) => Connectivity());

final httpLoaderProvider = Provider((ref) => HttpLoader(ref: ref));

class HttpLoader {
  const HttpLoader({
    required this.ref,
  });

  final ProviderRef ref;

  Stream<Result<InternetFeedback, Response>> accessUrl({
    required String url,
    required CancelToken cancelToken,
  }) async* {
    Response response;
    final dio = ref.read(dioProvider);

    try {
      response = await dio.get(url, cancelToken: cancelToken);
      yield Success(response);
    } on DioError catch (e) {
      if (_noInternet(e)) {
        final Connectivity connectivity = ref.read(connectivityProvider);
        final ConnectivityResult connectivityResult =
            await connectivity.checkConnectivity();

        if (connectivityResult != ConnectivityResult.none) {
          yield Error(NoInternetFailure(url: url));
        } else {
          yield* _retryWhenConnected(url, connectivity, dio, e);
        }
      } else {
        rethrow;
      }
    }
  }

   Stream<Result<InternetFeedback, Response>> _retryWhenConnected
       (String url, Connectivity connectivity, Dio dio, DioError e) async* {
    yield Error(NoInternetRetryFailure(url: url));

    try {
      await connectivity.onConnectionFound();
      yield Error(InternetLoading(url: url));

      final response = await dio.retry(options: e.requestOptions);

      yield Success(response);
    } on DioError catch (e) {
      if (_noInternet(e)) {
        yield Error(NoInternetFailure(url: url));
      } else {
        rethrow;
      }
    }
  }


  bool _noInternet(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }
}
