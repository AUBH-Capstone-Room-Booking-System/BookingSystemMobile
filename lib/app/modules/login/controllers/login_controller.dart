import 'package:bookingstore/AppContants.dart';
import 'package:bookingstore/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _getStorage = GetStorage();

  void login() async {
    // Create Dio instance
    Dio dio = Dio();

    try {
      print("${AppConstants.hostUrl}/user/login");
      var response = await dio.post(
          "${AppConstants.hostUrl}/user/login",data: {
        "email":email.text,
        "password":password.text
      }
      );

      if(response.data['user']!=null){
        print(response.data['user']["firstName"]);
        prefs.setString("firstName",response.data['user']["firstName"]);
        prefs.setString("lastName",response.data['user']["lastName"]);
        prefs.setString("email",response.data['user']["email"]);
        prefs.setString("phoneNumber",response.data['user']["phoneNumber"]);
        prefs.setInt("myId",response.data['user']["id"]);


        Get.offAndToNamed("/");
      }else{
        Get.snackbar("Login", "Wrong email and password",  snackPosition: SnackPosition.BOTTOM);
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  final count = 0.obs;
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

  void increment() => count.value++;
}