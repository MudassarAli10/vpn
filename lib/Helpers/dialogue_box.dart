import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogue{

  static success({required String message}){
    Get.snackbar('Success', message, colorText: Colors.white,backgroundColor:Colors.green );
  }

  static error({required String message}){
    Get.snackbar('Error', message, colorText: Colors.white);

  }

  static info({required String message}){
    Get.snackbar('Information', message, colorText: Colors.white);
  }

  static showProgress(){
    Get.dialog(Center(child: CircularProgressIndicator(strokeWidth: 2,)));
  }
}
