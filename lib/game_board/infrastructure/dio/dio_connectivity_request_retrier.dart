import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

import '../scrapper.dart';

final dioConnectivityRequestRetrierProvider =
Provider((ref) => DioConnectivityRequestRetrier(riverpodReader: ref.read));

class DioConnectivityRequestRetrier {
  DioConnectivityRequestRetrier({required this.riverpodReader});

  final Reader riverpodReader;

  Future<ConnectivityResult> onConnectionFound() async {
    final Connectivity connectivity = riverpodReader(connectivityProvider);


    return connectivity.onConnectivityChanged.firstWhere((
        connectivityResult) => connectivityResult != ConnectivityResult.none);

// yield*
//   connectivity.onConnectivityChanged.listen<Result<bool, Response>>(
//           (connectivityResult) {
//     if (connectivityResult != ConnectivityResult.none) {
//       yield Error(true);
//       final Response response = await dio.request(
//         requestOptions.path,
//         cancelToken: requestOptions.cancelToken,
//         data: requestOptions.data,
//         onReceiveProgress: requestOptions.onReceiveProgress,
//         onSendProgress: requestOptions.onSendProgress,
//         queryParameters: requestOptions.queryParameters,
//       );
//       yield Success(response);
//     }
//   });
  }
}


