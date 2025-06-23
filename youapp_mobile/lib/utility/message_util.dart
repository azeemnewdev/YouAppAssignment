import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageUtil {
  static void showErrorMessage(Map<String, dynamic> responseData) {
    var messages = getMessage(responseData);
    Future.delayed(Duration.zero, () {
      Get.snackbar(
        'Error',
        messages,
        icon: Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade700,
        borderRadius: 10,
        margin: EdgeInsets.all(8),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    });
  }

  static void showSuccessMessage(Map<String, dynamic> responseData) {
    var messages = getMessage(responseData);
    Future.delayed(Duration.zero, () {
      Get.snackbar(
        'Success',
        messages,
        icon: Icon(Icons.check_circle, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade700,
        borderRadius: 10,
        margin: EdgeInsets.all(8),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    });
  }

  static String getMessage(Map<String, dynamic> responseData) {
    return responseData['message'] is String
        ? responseData['message']
        : responseData['message'][0];
  }
}
