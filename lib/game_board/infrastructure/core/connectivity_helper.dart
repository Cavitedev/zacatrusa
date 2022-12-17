import 'package:connectivity_plus/connectivity_plus.dart';
import '../http_loader.dart';

extension ConnectivityX on Connectivity {
  Future<ConnectivityResult> onConnectionFound() async {
    return onConnectivityChanged.firstWhere(
            (connectivityResult) {
              print(connectivityResult);
              return internetConnections.contains(connectivityResult);
  });
  }
}
