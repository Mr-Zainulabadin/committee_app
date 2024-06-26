// import 'package:get/get.dart';

// import '../../Utils.dart';

// class NetworkProvider extends GetxController {
//   final Connectivity _connectivity = Connectivity();

//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen((event) {
//       _updateConnectionStatus(event[0]);
//     });
//   }

//   void _updateConnectionStatus(ConnectivityResult connectivityResult) async {
//     bool isConnected = await Utils.checkUserInternetConnection();
//     if (!isConnected) {
//       if (Get.isSnackbarOpen) {
//         Get.closeCurrentSnackbar();
//       }
//       Utils.snackBarErrorMessage("No Internet connection!", true, const Duration(days: 1));
//     } else if (isConnected) {
//       if (Get.isSnackbarOpen) {
//         Get.closeCurrentSnackbar();
//       }
//       Utils.snackBarMessage("Your connection is now Active", true, const Duration(seconds: 1));
//     }
//   }
// }
