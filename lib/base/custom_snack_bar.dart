import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, {bool isError = true, String title = ''}){
  Get.snackbar(title, message,
    titleText: Text(title, style: const TextStyle(
      color: Colors.black,
    )),
    messageText: Text(message, style: const TextStyle(
      color: Colors.black,
    ),),
    colorText: Colors.black,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.blueGrey.withOpacity(0.5),
    dismissDirection: DismissDirection.vertical,
    isDismissible: true,
  );
}