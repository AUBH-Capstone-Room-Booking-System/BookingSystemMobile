import 'package:bookingstore/AppContants.dart';
import 'package:bookingstore/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
class HomeController extends GetxController {

bool isAdmin=false;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    var userType=prefs.getString("userType");
    if(userType=="Admin"){
      isAdmin=true;
    }
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
