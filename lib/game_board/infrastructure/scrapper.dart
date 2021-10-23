import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:zacatrusa/game_board/infrastructure/core/web_exceptions.dart';
import 'package:zacatrusa/game_board/infrastructure/dio/dio_connectivity_request_retrier.dart';

final Provider<Dio> dioProvider = Provider<Dio>((_) => Dio());
final Provider<Connectivity> connectivityProvider =
    Provider<Connectivity>((_) => Connectivity());

final scrapperProvider = Provider((ref) => Scapper(ref: ref));

class Scapper {
  const Scapper({
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
          yield Error(NoInternetRetryError(msg: """
No estás conectado a ninguna red.
Activa la wifi, cable ethernet o datos móviles.
La conexión con $url se repetirá automáticamente"""));

          DioConnectivityRequestRetrier requestRetrier =
              ref.read(dioConnectivityRequestRetrierProvider);

          try {
            await requestRetrier.onConnectionFound();
            yield Error(InternetLoading(msg: "Reloading $url"));
            final Response response = await dio.request(
              e.requestOptions.path,
              cancelToken: e.requestOptions.cancelToken,
              data: e.requestOptions.data,
              onReceiveProgress: e.requestOptions.onReceiveProgress,
              onSendProgress: e.requestOptions.onSendProgress,
              queryParameters: e.requestOptions.queryParameters,
            );

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

  NoInternetError _noInternetError(String url) {
    return NoInternetError(msg: """
No hay internet para conectarse a $url.
compruebe su conexión""");
  }

  bool _noInternet(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }
}
