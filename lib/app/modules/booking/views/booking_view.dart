import 'package:bookingstore/AppColors.dart';
import 'package:bookingstore/AppContants.dart';
import 'package:bookingstore/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../widgets/BottomNavBarWidget.dart';
import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<BookingController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {

                        Get.back();


                    },
                    icon: Icon(Icons.chevron_left),
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date"),
                  TextFormField(
                    controller: controller.date,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null &&
                          pickedDate != controller.date.text) {
                        String formattedDate =
                            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}";

                        controller.date.text = formattedDate;
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today),
                      helperText: "Choose a date",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("From:"),
                        TextFormField(
                          controller: controller.startTime,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (pickedTime != null) {
                              String formattedHour =
                                  pickedTime.hour.toString().padLeft(2, '0');
                              String formattedMinute =
                                  pickedTime.minute.toString().padLeft(2, '0');
                              String formattedTime =
                                  "$formattedHour:$formattedMinute";

                              controller.startTime.text = formattedTime;
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.access_time),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.blue,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("To:"),
                        TextFormField(
                          controller: controller.endTime,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (pickedTime != null) {
                              String formattedHour =
                                  pickedTime.hour.toString().padLeft(2, '0');
                              String formattedMinute =
                                  pickedTime.minute.toString().padLeft(2, '0');
                              String formattedTime =
                                  "$formattedHour:$formattedMinute";

                              // Check if the selected time is after the "From" time
                              if (controller.startTime.text.isNotEmpty &&
                                  formattedTime.compareTo(
                                          controller.startTime.text) <
                                      0) {
                                controller.endTime.text = formattedTime;
                                controller.startTime.text = "";
                              } else {
                                // Set the selected time if it's valid
                                controller.endTime.text = formattedTime;
                                print(formattedTime);
                                controller.getRooms();
                              }
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.access_time),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.blue,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text("Available rooms:"),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 1.5),
                          itemCount: controller.rooms.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: ()async {
                                if (controller.rooms[index]["roomStatus"] ==
                                    "Occupied") {
                                  Get.snackbar("Occupied", "Room is occupied",snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: AppColors.occupiedColor);
                                }else if(controller.rooms[index]["roomStatus"] ==
                                    "Booked"){
                                  Get.snackbar("Booked", "Room is booked",snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: AppColors.bookedColor);
                                }else{
                                  controller.roomNumber=index;
                                  Dio dio=Dio();
                                  var reqData = {
                                    "roomNumber": index+1,
                                  };
                                  var response =
                                      await dio.post("${AppConstants.hostUrl}/sensor/find", data: reqData);
                                  var id =prefs.getInt("id");
                                  print(id);
                                  reqData = {
                                    "userId": id!,
                                    "roomNumber":index+1
                                  };
                                  controller.isFavorite=false;
                                  controller.update();
                                  var favoriteResponse=await dio.post("${AppConstants.hostUrl}/favorite/findone", data: reqData);
                                  print(favoriteResponse.data);
                                  if(favoriteResponse.data["favorite"]!=null){
                                    controller.isFavorite=true;
                                    controller.update();
                                  }
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Row(
                                          children: [
                                            Text('Selected Room Readings'),
                                            IconButton(onPressed: (){
                                              if(controller.isFavorite){
                                                controller.removeFromFavorite();
                                                Navigator.of(context).pop();

                                              }else{
                                                controller.addToFavorite();
                                                Navigator.of(context).pop();

                                              }
                                            }, icon: Icon(controller.isFavorite?Icons.star:Icons.star_border_outlined))
                                          ],
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                                Text("PIR Sensor: ${response.data["sensorData"]["motion"]}"),

                                            Text("Temperature: ${response.data["sensorData"]["temperature"]}"),
                                            Text("Humidity: ${response.data["sensorData"]["humidity"]}"),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,mainAxisSize: MainAxisSize.min,children: [
                                              Text("Comfort: ${response.data["sensorData"]["comfort"]}"),
                                              SizedBox(width: 10,),
                                              Tooltip(

                                               message: "For a room to get 5 stars it need to be ...",

                                                child: Icon(Icons.info_outline),
                                              )
                                            ],)

                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              // Close the alert dialog
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  controller.update();
                                }
                              },
                              child:controller.roomNumber==index? Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: AppColors.mainColor!,
                                      width: 2
                                    )),
                                    margin: EdgeInsets.all(6),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 9, horizontal: 24),
                                    child: Center(
                                      child: Text(
                                        'Room ${index + 1}',
                                        style: TextStyle(color: AppColors.mainColor),
                                      ),
                                    ),
                                  ),
                                  Text("Category : ${controller.rooms[index]["roomSize"]=="s"?"Small":controller.rooms[index]["roomSize"]=="m"?"Medium":"Large"}"),
                                  Text("Capacity : ${controller.rooms[index]["roomCapacity"]}")
                                ],
                              ): Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: controller.rooms[index]
                                        ["roomStatus"] ==
                                            "Available"
                                            ? AppColors.mainColor
                                            : controller.rooms[index]
                                        ["roomStatus"] ==
                                            "Occupied"
                                            ? AppColors.occupiedColor
                                            : AppColors.bookedColor,
                                        borderRadius: BorderRadius.circular(30)),
                                    margin: EdgeInsets.all(6),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 9, horizontal: 24),
                                    child: Center(
                                      child: Text(
                                        'Room ${index + 1}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Text("Category : ${controller.rooms[index]["roomSize"]=="s"?"Small":controller.rooms[index]["roomSize"]=="m"?"Medium":"Large"}"),
                                  Text("Capacity : ${controller.rooms[index]["roomCapacity"]}")

                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Purpose:"),
                  TextFormField(
                    controller: controller.purpose,
                    decoration: InputDecoration(
                      helperText: "Ex: Exam Preparation",

                      border: OutlineInputBorder(
                        // Set the border width and color
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.blue,
                        ),
                        // Set the border radius
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      // Optionally add padding to the border
                      // contentPadding: EdgeInsets.all(8.0),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  print("heelo");
                  controller.bookRoom();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Text(
                    "Book Room",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      },
    ));
  }
}
