import 'package:bookingstore/AppColors.dart';
import 'package:bookingstore/app/modules/widgets/BottomNavBarWidget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/calendar_controller.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 1,
      ),
      body: GetBuilder<CalendarController>(builder: (controller){
        return Container(
          padding: EdgeInsets.all(20),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Calendar",style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),),
          TableCalendar(
            locale: "en_US",
            rowHeight: 50,
            headerStyle: HeaderStyle(formatButtonVisible: false,titleCentered: true),
            availableGestures: AvailableGestures.all,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            selectedDayPredicate: (day)=>isSameDay(day, controller.today),
            focusedDay: controller.today,
            onDaySelected: (day,focusedDay){
              controller.changeDay(day, focusedDay);
            },
          ),
              SizedBox(
                height: 30,
              ),
              Expanded(child: ListView.builder(itemCount: controller.myBookings.length,itemBuilder: (context,index){
                var splitedDate =
                controller.myBookings[index]["startDate"].split("/");
                final int year = int.parse(splitedDate[2]);
                final int month = int.parse(splitedDate[1]);
                final int day = int.parse(splitedDate[0]);

                final DateTime startDate = DateTime(year, month, day);

                final formattedDate =
                DateFormat('dd MMMM yyyy', 'en_US')
                    .format(startDate);
                return Container(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(formattedDate),
                      SizedBox(height:10,),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed("/editbooking");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 9,horizontal: 24),
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor,
                            borderRadius: BorderRadius.circular(24)
                          ),
                          child: Text("${controller.myBookings[index]["purpose"]} (${controller.myBookings[index]["startTime"]} - ${controller.myBookings[index]["endTime"]})",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ],
                  ),
                );
              }))
            ],
          ),
        );
      },)
    );
  }
}
