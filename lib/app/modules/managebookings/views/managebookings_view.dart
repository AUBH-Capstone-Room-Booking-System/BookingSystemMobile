import 'package:bookingstore/AppColors.dart';
import 'package:bookingstore/AppContants.dart';
import 'package:bookingstore/app/modules/editbooking/controllers/editbooking_controller.dart';
import 'package:bookingstore/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/managebookings_controller.dart';

class ManagebookingsView extends GetView<ManagebookingsController> {
  const ManagebookingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<ManagebookingsController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      var editbookingcontroller=Get.find<EditbookingController>();
                      if(editbookingcontroller.currentStackIndex==1){
                        editbookingcontroller.currentStackIndex=0;
                        controller.update();
                      }else{
                        Get.back();

                      }
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
              Expanded(
                child: GetBuilder<EditbookingController>(
                  builder: (controller) {
                    return Container(
                      child: IndexedStack(
                        index: controller.currentStackIndex,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select a meeting to edit",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              controller.isLoading
                                  ? CircularProgressIndicator()
                                  : Expanded(
                                      child: ListView.builder(
                                        itemCount: controller.bookings.length,
                                        itemBuilder: (context, index) {
                                          var splitedDate = controller
                                              .bookings[index]["startDate"]
                                              .split("/");
                                          final int year =
                                              int.parse(splitedDate[2]);
                                          final int month =
                                              int.parse(splitedDate[1]);
                                          final int day =
                                              int.parse(splitedDate[0]);
                
                                          final DateTime startDate =
                                              DateTime(year, month, day);
                
                                          final formattedDate =
                                              DateFormat('dd MMMM yyyy', 'en_US')
                                                  .format(startDate);
                
                                          return Container(
                                            margin: EdgeInsets.only(bottom: 20),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  width: 1,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${formattedDate} - ${controller
                                                      .bookings[index]["guest"]}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.selectedBooking =
                                                        index;
                                                    controller.selectedBookingId =
                                                        controller.bookings[index]
                                                            ["id"];
                                                    controller.update();
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 9,
                                                        horizontal: 24),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                24),
                                                        color: controller
                                                                    .selectedBooking ==
                                                                index
                                                            ? Colors.white
                                                            : AppColors.mainColor,
                                                        border: controller
                                                                    .selectedBooking ==
                                                                index
                                                            ? Border.all(
                                                                color: AppColors
                                                                    .mainColor!,
                                                                width: 2)
                                                            : null),
                                                    child: Text(
                                                      "${controller.bookings[index]["purpose"]} (${controller.bookings[index]["startTime"]} - ${controller.bookings[index]["endTime"]})",
                                                      style: TextStyle(
                                                          color: controller
                                                                      .selectedBooking ==
                                                                  index
                                                              ? AppColors
                                                                  .mainColor
                                                              : Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.startDateController.text =
                                              controller.bookings[controller
                                                  .selectedBooking]["startDate"];
                                          controller.endTimeController.text =
                                              controller.bookings[controller
                                                  .selectedBooking]["endTime"];
                                          controller.startTimeController.text =
                                              controller.bookings[controller
                                                  .selectedBooking]["startTime"];
                                          controller.purposeController.text =
                                              controller.bookings[controller
                                                  .selectedBooking]["purpose"];
                                          controller.selectedRoom = controller
                                                          .bookings[
                                                      controller.selectedBooking]
                                                  ["roomNumber"] -
                                              1;
                                          controller.prevBookingId = controller
                                                  .bookings[
                                              controller.selectedBooking]["id"];
                
                                          controller.getRooms();
                                          controller.currentStackIndex = 1;
                                          controller.update();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 13, horizontal: 24),
                                          child: Text(
                                            "Edit Selected Booking",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.cancelBooking();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.bookedColor,
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 13, horizontal: 24),
                                          child: Text(
                                            "Cancel Booking",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date"),
                                  TextFormField(
                                    controller: controller.startDateController,
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2101),
                                      );
                
                                      if (pickedDate != null &&
                                          pickedDate !=
                                              controller
                                                  .startDateController.text) {
                                        String formattedDate =
                                            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}";
                
                                        controller.startDateController.text =
                                            formattedDate;
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("From:"),
                                        TextFormField(
                                          controller:
                                              controller.startTimeController,
                                          onTap: () async {
                                            TimeOfDay? pickedTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                
                                            if (pickedTime != null) {
                                              String formattedHour = pickedTime
                                                  .hour
                                                  .toString()
                                                  .padLeft(2, '0');
                                              String formattedMinute = pickedTime
                                                  .minute
                                                  .toString()
                                                  .padLeft(2, '0');
                                              String formattedTime =
                                                  "$formattedHour:$formattedMinute";
                
                                              controller.startTimeController
                                                  .text = formattedTime;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            suffixIcon: Icon(Icons.access_time),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.blue,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("To:"),
                                        TextFormField(
                                          controller:
                                              controller.endTimeController,
                                          onTap: () async {
                                            TimeOfDay? pickedTime =
                                                await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                
                                            if (pickedTime != null) {
                                              String formattedHour = pickedTime
                                                  .hour
                                                  .toString()
                                                  .padLeft(2, '0');
                                              String formattedMinute = pickedTime
                                                  .minute
                                                  .toString()
                                                  .padLeft(2, '0');
                                              String formattedTime =
                                                  "$formattedHour:$formattedMinute";
                
                                              // Check if the selected time is after the "From" time
                                              if (controller.startTimeController
                                                      .text.isNotEmpty &&
                                                  formattedTime.compareTo(
                                                          controller
                                                              .startTimeController
                                                              .text) <
                                                      0) {
                                                controller.endTimeController
                                                    .text = formattedTime;
                                                controller.startTimeController
                                                    .text = "";
                                              } else {
                                                // Set the selected time if it's valid
                                                controller.endTimeController
                                                    .text = formattedTime;
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
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
                                                  crossAxisCount: 3,
                                                  childAspectRatio: 3),
                                          itemCount: controller.rooms.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return GestureDetector(
                                              onTap: () async {
                                                if (controller.rooms[index]
                                                        ["roomStatus"] ==
                                                    "Occupied") {
                                                  Get.snackbar("Occupied",
                                                      "Room is occupied",
                                                      snackPosition:
                                                          SnackPosition.BOTTOM,
                                                      backgroundColor: AppColors
                                                          .occupiedColor);
                                                } else if (controller.rooms[index]
                                                        ["roomStatus"] ==
                                                    "Booked") {
                                                  Get.snackbar(
                                                      "Booked", "Room is booked",
                                                      snackPosition:
                                                          SnackPosition.BOTTOM,
                                                      backgroundColor:
                                                          AppColors.bookedColor);
                                                } else {
                                                  controller.selectedRoom = index;
                                                  Dio dio = Dio();
                                                  var reqData = {
                                                    "roomNumber": index + 1,
                                                  };
                                                  var response = await dio.post(
                                                      "${AppConstants.hostUrl}/sensor/find",
                                                      data: reqData);
                
                                                  var id = prefs.getInt("id");
                                                  reqData = {
                                                    "userId": id!,
                                                    "roomNumber": index + 1
                                                  };
                                                  controller.isFavorite = false;
                                                  controller.update();
                                                  var favoriteResponse =
                                                      await dio.post(
                                                          "${AppConstants.hostUrl}/favorite/findone",
                                                          data: reqData);
                                                  print(favoriteResponse.data);
                                                  if (favoriteResponse
                                                          .data["favorite"] !=
                                                      null) {
                                                    controller.isFavorite = true;
                                                    controller.update();
                                                  }
                                                  showDialog<void>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Row(
                                                          children: [
                                                            Text(
                                                                'Selected Room Readings'),
                                                            IconButton(
                                                                onPressed: () {
                                                                  if (controller
                                                                      .isFavorite) {
                                                                    controller
                                                                        .removeFromFavorite();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  } else {
                                                                    controller
                                                                        .addToFavorite();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  }
                                                                },
                                                                icon: Icon(controller
                                                                        .isFavorite
                                                                    ? Icons.star
                                                                    : Icons
                                                                        .star_border_outlined))
                                                          ],
                                                        ),
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                                "PIR Sensor: ${response.data["sensorData"]["motion"]}"),
                                                            Text(
                                                                "Temperature: ${response.data["sensorData"]["temperature"]}")
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              // Close the alert dialog
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
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
                                              child: controller.selectedRoom ==
                                                      index
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .mainColor!,
                                                              width: 2)),
                                                      margin: EdgeInsets.all(6),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 9,
                                                              horizontal: 24),
                                                      child: Center(
                                                        child: Text(
                                                          'Room ${index + 1}',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .mainColor),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                          color: controller.rooms[
                                                                          index][
                                                                      "roomStatus"] ==
                                                                  "Available"
                                                              ? AppColors
                                                                  .mainColor
                                                              : controller.rooms[
                                                                              index]
                                                                          [
                                                                          "roomStatus"] ==
                                                                      "Occupied"
                                                                  ? AppColors
                                                                      .occupiedColor
                                                                  : AppColors
                                                                      .bookedColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30)),
                                                      margin: EdgeInsets.all(6),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 9,
                                                              horizontal: 24),
                                                      child: Center(
                                                        child: Text(
                                                          'Room ${index + 1}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
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
                                    controller: controller.purposeController,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.calendar_today),
                                      helperText: "Ex: Exam Preparation",
                                      border: OutlineInputBorder(
                                        // Set the border width and color
                                        borderSide: BorderSide(
                                          width: 2.0,
                                          color: Colors.blue,
                                        ),
                                        // Set the border radius
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.editBooking();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Text(
                                    "Edit Booking",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    ));
  }
}
