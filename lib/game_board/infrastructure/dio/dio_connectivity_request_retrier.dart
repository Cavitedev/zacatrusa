import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/infrastructure/dio/dio_retry_interceptor.dart';

final dioConnectivityRequestRetrierProvider =
    Provider((ref) => DioConnectivityRequestRetrier(riverpodReader: ref.read));

class DioConnectivityRequestRetrier {
  DioConnectivityRequestRetrier({required this.riverpodReader});

  final Reader riverpodReader;

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    final Connectivity connectivity = riverpodReader(connectivityProvider);
    final Dio dio = riverpodReader(dioProvider);


    final responseCompleter = Completer<Response>();

    StreamSubscription onConnectivityChange =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult != ConnectivityResult.none) {
        responseCompleter.complete(dio.request(
          requestOptions.path,
          cancelToken: requestOptions.cancelToken,
          data: requestOptions.data,
          onReceiveProgress: requestOptions.onReceiveProgress,
          onSendProgress: requestOptions.onSendProgress,
          queryParameters: requestOptions.queryParameters,
        ));
      }
    });


    return _manageOnRetryResult(responseCompleter, onConnectivityChange);
  }

  Future<Response<dynamic>> _manageOnRetryResult(
      Completer<Response<dynamic>> responseCompleter,
      StreamSubscription<dynamic> onConnectivityChange) async {
    final response = await responseCompleter.future;
    onConnectivityChange.cancel();
    return response;
  }
}
