import 'package:connectivity_plus/connectivity_plus.dart';

import 'bloc/network_bloc.dart';

class NetworkHelper {
 static void observeNetwork() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      NetworkBloc().add(NetworkNotify(isConnected: false));
    } else {
      NetworkBloc().add(NetworkNotify(isConnected: true));
    }
  }
}
