import 'package:bookingstore/AppColors.dart';
import 'package:bookingstore/app/modules/editbooking/controllers/editbooking_controller.dart';
import 'package:bookingstore/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:bookingstore/app/modules/widgets/BottomNavBarWidget.dart';
import 'package:bookingstore/main.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var editBookingController = Get.find<EditbookingController>();
    var favoriteController = Get.find<FavoritesController>();
    var name = prefs.getString("firstName");
    return Scaffold(
        bottomNavigationBar: BottomNavBarWidget(
          currentIndex: 0,
        ),

        body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello, ${name}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Get.toNamed("/booking");
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(24)),
                            child: Center(
                                child: Text(
                              "Book A Room",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(24)),
                          child: Center(
                              child: Text(
                            "Visit Rooms",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            editBookingController.getBooking();
                            Get.toNamed("/editbooking");
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(24)),
                            child: Center(
                                child: Text(
                              "Edit Booking",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            favoriteController.getFavorites();
                            Get.toNamed("/favorites");
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(24)),
                            child: Center(
                                child: Text(
                              "View Favorite Rooms",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    controller.isAdmin
                        ? Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  Get.toNamed("/manageusers");
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Center(
                                      child: Text(
                                    "Manage Users",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              )),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  Get.toNamed("/managebookings");
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Center(
                                      child: Text(
                                    "Manage Rooms",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              )),
                            ],
                          )
                        : SizedBox.shrink()
                  ],
                ),
                SizedBox(
                  height: 100,
                )
              ],
            )));
  }
}
