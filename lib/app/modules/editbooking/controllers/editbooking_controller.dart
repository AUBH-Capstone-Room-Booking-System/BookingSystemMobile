import 'package:bookingstore/AppContants.dart';
import 'package:bookingstore/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditbookingController extends GetxController {
  TextEditingController startDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController purposeController = TextEditingController();

  var isLoading = false;
  var bookings = [];
  var rooms = [];
  var isFavorite=false;

  var currentStackIndex = 0;
  var selectedBooking = -1;
  var prevBookingId = -1;
  var selectedRoom = -1;
  var selectedBookingId = -1;
  var startTime = "";
  var endTime = "";
  var startDate = "";
  var purpose = "";

  addToFavorite() async{
    Dio dio = Dio();

    try {
      var id=prefs.getInt("myId");
      var reqData = {
        "roomNumber":selectedRoom+1,
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
        "roomNumber":selectedRoom+1,
        "userId": id,
      };
      var response =
      await dio.post("${AppConstants.hostUrl}/favorite/delete", data: reqData);
      Get.snackbar("Removed", "removed room from favorites!",snackPosition: SnackPosition.BOTTOM);

    } catch (error) {
      print('Error: $error');
    }
  }

  cancelBooking() async {
    Dio dio = Dio();

    try {
      var response = await dio.delete(
          "${AppConstants.hostUrl}/booking/delete/${selectedBookingId}");
      Get.snackbar("success", "Canceled booking",  snackPosition: SnackPosition.BOTTOM);
      bookings.removeAt(selectedBooking);

      currentStackIndex = 0;
      selectedBooking = -1;
      prevBookingId = -1;
      selectedRoom = -1;
      selectedBookingId = -1;
      update();
      Get.toNamed("/");
    } catch (error) {
      print('Error: $error');
    }
  }

  getBooking() async {
    Dio dio = Dio();

    try {
      var id = prefs.getInt("myId");
      isLoading = true;
      update();
      var response =
          await dio.get("${AppConstants.hostUrl}/booking/find/${id}");

      bookings.assignAll(response.data["bookings"]);
      isLoading = false;
      update();
    } catch (error) {
      print('Error: $error');
    }
  }

  getRooms() async {
    Dio dio = Dio();

    try {
      var reqData = {
        "startDate": startDateController.text,
        "startTime": startTimeController.text,
        "endTime": endTimeController.text,
      };
      isLoading = true;
      update();

      var response =
          await dio.post("${AppConstants.hostUrl}/booking/find", data: reqData);
      rooms.assignAll(response.data['rooms']);

      isLoading = false;
      update();
    } catch (error) {
      print('Error: $error');
    }
  }

  editBooking() async {
    Dio dio = Dio();

    try {
      var reqData = {
        "roomNumber": selectedRoom + 1,
      };
      print(reqData);
      var response = await dio.post(
          "${AppConstants.hostUrl}/booking/edit/${prevBookingId}",
          data: reqData);
      Get.snackbar(
        'Success',
        "Edited booking successfully",  snackPosition: SnackPosition.BOTTOM
      );
      currentStackIndex = 0;
      selectedBooking = -1;
      update();
      Get.toNamed("/");
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void onInit() {
    super.onInit();
    currentStackIndex = 0;
    selectedBooking = -1;
    prevBookingId = -1;
    selectedRoom = -1;
    selectedBookingId = -1;
    getBooking();
  }

  @override
  void onReady() {
    super.onReady();
    getBooking();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
