import 'package:bookingstore/AppContants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetController extends GetxController {
  //TODO: Implement ResetController
TextEditingController email=TextEditingController();
TextEditingController firstPassword=TextEditingController();
TextEditingController secondPassword=TextEditingController();
bool obscureText=true;
confirm()async{
  if(firstPassword.text!=secondPassword.text){
    Get.snackbar("Error", "Passwords need to match",snackPosition: SnackPosition.BOTTOM,colorText: Colors.white,backgroundColor: Colors.red);
  return ;
  }

  Dio dio = Dio();

  try {
    print("${AppConstants.hostUrl}/user/reset");
    var reqData={
      "email":email.text,
      "password":firstPassword.text
    };
    print(reqData);
    var response = await dio.post(
        "${AppConstants.hostUrl}/user/reset",data: reqData
    );

      Get.snackbar("Success", "Password has been reset",snackPosition: SnackPosition.BOTTOM,);
      Get.toNamed("/login");



  } catch (error) {
    Get.snackbar("Error", "Email doesn't exist",snackPosition: SnackPosition.BOTTOM,colorText: Colors.white,backgroundColor: Colors.red);
  }
}

@override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
