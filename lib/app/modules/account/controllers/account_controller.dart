import 'package:bookingstore/AppContants.dart';
import 'package:bookingstore/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  //TODO: Implement AccountController

  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();

  TextEditingController email=TextEditingController();

  TextEditingController phoneNumber=TextEditingController();


  logout() async{
prefs.clear();
Get.offAllNamed("/login");
  }

  editAccount() async{
    Dio dio = Dio();
    try {
      var id=prefs.getInt("myId");
      var reqData = {
        "firstName":firstName.text,
        "lastName":lastName.text,
        "email": email.text,
        "phoneNumber":phoneNumber.text
      };
      print(reqData);
      var response =
      await dio.post("${AppConstants.hostUrl}/user/edit/${id}", data: reqData);

      prefs.setString("firstName",response.data['user']["firstName"]);
      prefs.setString("lastName",response.data['user']["lastName"]);
      prefs.setString("email",response.data['user']["email"]);
      prefs.setString("phoneNumber",response.data['user']["phoneNumber"]);
      prefs.setInt("myId",response.data['user']["id"]);
      Get.offAllNamed("/");
      update();
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void onInit() {
    super.onInit();
    firstName.text=prefs.getString("firstName")!;
    lastName.text=prefs.getString("lastName")!;

    email.text=prefs.getString("email")!;
    phoneNumber.text=prefs.getString("phoneNumber")!;


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
