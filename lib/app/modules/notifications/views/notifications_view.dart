import 'package:bookingstore/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<NotificationsController>(
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
              Text("Notifications",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
              Expanded(
                  child: ListView.builder(
                    reverse: true,
                      itemCount: controller.notifications.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(5)

                          ),
                          child: Row(
                            children: [
                              Icon(Icons.notifications,color: Colors.white,),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Text(controller.notifications[index]["content"],style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                                ),),
                              ),
                            ],
                          ),
                        );
                      }))
            ],
          ),
        );
      },
    ));
  }
}
