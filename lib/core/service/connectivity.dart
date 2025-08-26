import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnection {
  Future<bool> checkInternet() async {
    final List<ConnectivityResult> connectivityResult = 
        await Connectivity().checkConnectivity();
        
    print(connectivityResult);

    // Daftar tipe koneksi yang valid
    const validResults = {
      ConnectivityResult.mobile,
      ConnectivityResult.wifi,
      ConnectivityResult.ethernet,
      ConnectivityResult.bluetooth,
      ConnectivityResult.other,
    };

    // Cek apakah ada minimal satu koneksi valid
    return connectivityResult.any((result) => validResults.contains(result));
  }
}