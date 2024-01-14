import 'package:bookingstore/AppColors.dart';
import 'package:bookingstore/AppContants.dart';
import 'package:bookingstore/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  //TODO: Implement BookingController

  TextEditingController date = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController purpose = TextEditingController();

  var isFavorite=false;
  var rooms = [];
  var roomNumber = -1;
  bookRoom() async {
    Dio dio = Dio();
    try {
      if (date.text == "" || startTime.text == "" || endTime.text == "") {
        Get.snackbar('Error', "You need to pick a time",
            backgroundColor: AppColors.bookedColor, colorText: Colors.white,  snackPosition: SnackPosition.BOTTOM);

        return;
      }
      if (purpose.text == "") {
        Get.snackbar('Error', "Write a purpose",
            backgroundColor: AppColors.bookedColor, colorText: Colors.white,  snackPosition: SnackPosition.BOTTOM);
        return;
      }
      if (roomNumber == -1) {
        Get.snackbar('Error', "Select a room",
            backgroundColor: AppColors.bookedColor, colorText: Colors.white,  snackPosition: SnackPosition.BOTTOM);
        return;
      }
      var reqData = {
        "startDate": date.text,
        "startTime": startTime.text,
        "endTime": endTime.text,
        "purpose": purpose.text,
        "userId": prefs.getInt("myId"),
        "roomNumber": roomNumber+1,
      };
      var response =
          await dio.post("${AppConstants.hostUrl}/booking/add", data: reqData);
      Get.snackbar("Added", "Successfully booked the room!",snackPosition: SnackPosition.BOTTOM);
      Get.toNamed("/");
    } catch (e) {}
  }

  getRooms() async {
    Dio dio = Dio();

    try {
      var reqData = {
        "startDate": date.text,
        "startTime": startTime.text,
        "endTime": endTime.text,
      };
      var response =
          await dio.post("${AppConstants.hostUrl}/booking/find", data: reqData);
      rooms.assignAll(response.data['rooms']);
      update();
    } catch (error) {
      print('Error: $error');
    }
  }

  addToFavorite() async{
    Dio dio = Dio();

    try {
      var id=prefs.getInt("myId");
      var reqData = {
        "roomNumber":roomNumber+1,
        "userId": id,
      };
      var response =
      await dio.post("${AppConstants.hostUrl}/favorite/add", data: reqData);
      Get.snackbar("Added", "Added room to favorites!",snackPosition: SnackPosition.BOTTOM);

    } catch (error) {
      print('Error: $error');
    }
  }

  removeFromFavorite() async{
    Dio dio = Dio();

    try {
      var id=prefs.getInt("myId");
      var reqData = {
        "roomNumber":roomNumber+1,
        "userId": id,
      };
      var response =
      await dio.post("${AppConstants.hostUrl}/favorite/delete", data: reqData);
      Get.snackbar("Added", "removed room from favorites!",snackPosition: SnackPosition.BOTTOM);

    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void onInit() {
    super.onInit();

    var pickedDate = DateTime.now();
    String formattedDate =
        "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}";

    date.text = formattedDate;
    startTime.text = "11:00";
    endTime.text = "12:00";
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
