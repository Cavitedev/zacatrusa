
import 'package:dio/dio.dart';

extension DioX on Dio{

  Future<Response> retry ({required RequestOptions options}) async{
               return await request(
              options.path,
              cancelToken: options.cancelToken,
              data: options.data,
              onReceiveProgress: options.onReceiveProgress,
              onSendProgress: options.onSendProgress,
              queryParameters: options.queryParameters,
            );
  }

}