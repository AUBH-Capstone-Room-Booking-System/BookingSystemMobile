import 'package:bookingstore/AppContants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  //TODO: Implement NotificationsController
bool isLoading=false;
var notifications=[];

  getNotifications()async {
      print("getting favorites");
      Dio dio = Dio();

      try {
        isLoading=true;
        update();
        var response = await dio.get(
            "${AppConstants.hostUrl}/notification");
        notifications.assignAll(response.data["notifications"]);
        isLoading=false;
        update();

      } catch (error) {
        print('Error: $error');
      }

  }

  @override
  void onInit() {
    super.onInit();
    getNotifications();
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
