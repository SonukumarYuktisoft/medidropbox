import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toastification/toastification.dart';

class ToastHelper {
  static success(String message, ) {
    toastification.show(
      context: Get.context!,
      type: ToastificationType.success,
      showIcon: true,
      title: Text(message),
      autoCloseDuration: Duration(seconds: 5),
      backgroundColor: Colors.green,
      icon: Icon(Icons.check_circle_outline,color: Colors.black,)
    );
  }

   static error({
    required String message,
  String?  description 
    }) {
    toastification.show(
      context: Get.context!,
      type: ToastificationType.error,
       style: ToastificationStyle.minimal,
      foregroundColor: Colors.black,
      title: Text(message),
      description: Text(description??message),
       showIcon: true,
      autoCloseDuration: const Duration(seconds: 8),
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.error_outline_rounded,color: Colors.black,)

    );
  }

  static info({ required String message}) {
    toastification.show(
      context: Get.context!,
      type: ToastificationType.info,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 7),
      showIcon: true,
      icon: Icon(Icons.info_outline_rounded,color: Colors.white,),
      backgroundColor: Colors.blue
    );
  }

   static warning({ required String message,
    String? description
   }) {
    toastification.show(
      context: Get.context!,
      type: ToastificationType.warning,
      backgroundColor: Colors.amber,
      style: ToastificationStyle.minimal,
      title: Text(description??message),
      description: Text(message),
      showIcon: true,
      foregroundColor: Colors.black,
      icon: Icon(Icons.warning_rounded,color: Colors.black ,),
      autoCloseDuration: const Duration(seconds: 10),
    );
  }
   
       
  
}