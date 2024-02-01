import 'package:bookingstore/AppContants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetController extends GetxController {
  //TODO: Implement ResetController
  TextEditingController email = TextEditingController();
  confirm() async {
    Dio dio = Dio();

    try {
      var response =
          await dio.post("${AppConstants.hostUrl}/user/findbyemail", data: {
        "email": email.text,
      });
      var user = response.data["user"];
      var emailCode = email.text.split("@")[0];
      if (response.statusCode == 200) {
        var response2 =
            await dio.post("${AppConstants.hostUrl}/notification/add", data: {
          "content":
              "${user["firstName"]} ${user["lastName"]} (${emailCode}) wants to reset their password",
        });

        Get.snackbar(
          "Success",
          "Notification sent to the admin",
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.toNamed("/login");
      } else {
        Get.snackbar("Error", "Email doesn't exist",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
      Get.snackbar("Errorr", "Email doesn't exist",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red);
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
