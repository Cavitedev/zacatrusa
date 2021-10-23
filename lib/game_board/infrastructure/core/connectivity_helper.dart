import 'package:connectivity_plus/connectivity_plus.dart';

extension ConnectivityX on Connectivity{


    Future<ConnectivityResult> onConnectionFound() async {
    return onConnectivityChanged.firstWhere((
        connectivityResult) => connectivityResult != ConnectivityResult.none);
  }

}