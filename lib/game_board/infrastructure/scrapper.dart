import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:zacatrusa/game_board/infrastructure/core/connectivity_helper.dart';
import 'package:zacatrusa/game_board/infrastructure/core/dio_helper.dart';
import 'package:zacatrusa/game_board/infrastructure/core/web_exceptions.dart';

final Provider<Dio> dioProvider = Provider<Dio>((_) => Dio());
final Provider<Connectivity> connectivityProvider =
    Provider<Connectivity>((_) => Connectivity());

final pageLoaderProvider = Provider((ref) => PageLoader(ref: ref));

class PageLoader {
  const PageLoader({
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
          yield Error(_noInternetError(url));
        } else {
          yield Error(NoInternetRetryFailure(msg: """
No estás conectado a ninguna red.
Activa la wifi, cable ethernet o datos móviles.
La conexión con $url se repetirá automáticamente"""));

          Connectivity connectivity = ref.read(connectivityProvider);

          try {
            await connectivity.onConnectionFound();
            yield Error(InternetLoading(msg: "Reloading $url"));

            final response = await dio.retry(options: e.requestOptions);

            yield Success(response);
          } on DioError catch (e) {
            if (_noInternet(e)) {
              yield Error(_noInternetError(url));
            } else {
              rethrow;
            }
          }
        }
      } else {
        rethrow;
      }
    }
  }

  NoInternetFailure _noInternetError(String url) {
    return NoInternetFailure(msg: """
No hay internet para conectarse a $url.
compruebe su conexión""");
  }

  bool _noInternet(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }
}
