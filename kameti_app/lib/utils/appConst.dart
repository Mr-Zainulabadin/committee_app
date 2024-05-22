import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {
  static snackBarErrorMessage(String message) {
    Get.showSnackbar(GetSnackBar(
        borderRadius: 10,
        margin: const EdgeInsets.all(20),
        message: message,
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 2),
        icon: const Icon(
          Icons.cancel_outlined,
          color: Colors.white,
        )));
  }

  static snackBarMessage(String message) {
    Get.showSnackbar(GetSnackBar(
        borderRadius: 10,
        margin: const EdgeInsets.all(20),
        message: message,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        icon: const Icon(
          Icons.check_circle_outline_outlined,
          color: Colors.white,
        )));
  }
}
