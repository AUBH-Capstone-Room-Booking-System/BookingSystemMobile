import 'package:bookingstore/AppContants.dart';
import 'package:bookingstore/main.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  //TODO: Implement CalendarController
DateTime today=DateTime.now();


var myBookings=[];
changeDay(day,focusedDay)async{
  today=day;
  var splitedDay=day.toString().split(" ")[0].split("-");
  var formatedDate="${splitedDay[2]}/${splitedDay[1]}/${splitedDay[0]}";

  Dio dio = Dio();
  var id=prefs.getInt("myId");
  try {
    var reqData = {
      "startDate":formatedDate,
      "userId":id
    };
    print(reqData);
    var response =
    await dio.post("${AppConstants.hostUrl}/booking/findbyday", data: reqData);
myBookings.assignAll(response.data["bookings"]);
    update();
  } catch (error) {
    print('Error: $error');
  }
  update();
}
  @override
  void onInit() {
    super.onInit();
    changeDay(DateTime.now(),DateTime.now());
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
