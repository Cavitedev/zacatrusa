import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/infrastructure/dio/dio_connectivity_request_retrier.dart';

final Provider<Dio> dioProvider = Provider<Dio>((_) => Dio());
final Provider<Connectivity> connectivityProvider = Provider<Connectivity>((
    _) => Connectivity());
final dioRetryOnConnectivityChangeInterceptorProvider = Provider<
    DioRetryOnConnectivityChangeInterceptor>(
    (ref) => DioRetryOnConnectivityChangeInterceptor(riverpodReader: ref.read));

class DioRetryOnConnectivityChangeInterceptor extends Interceptor {

  DioRetryOnConnectivityChangeInterceptor({
    required this.riverpodReader,
  });

  final Reader riverpodReader;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final retrier = riverpodReader(dioConnectivityRequestRetrierProvider);
    retrier.scheduleRequestRetry(err.requestOptions);
    handler.next(err);
  }


  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other && err.error != null &&
        err.error is SocketException;
  }

}