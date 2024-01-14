import 'package:bookingstore/AppColors.dart';
import 'package:bookingstore/AppContants.dart';
import 'package:bookingstore/app/modules/widgets/BottomNavBarWidget.dart';
import 'package:bookingstore/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBarWidget(
          currentIndex: 0,
        ),
        body:GetBuilder<FavoritesController>(builder: (controller){
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Favorite Rooms",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                controller.isLoading
                    ? CircularProgressIndicator()
                    : Expanded(
                    child: ListView.builder(
                        itemCount: controller.favorites.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async{
                              controller.selectedFavoriteRoom=controller.favorites[index]["roomNumber"];
                              controller.selectedFavorite=index;
                              Dio dio=Dio();
                              var reqData = {
                                "roomNumber": controller.selectedFavoriteRoom,
                              };
                              var response =
                              await dio.post("${AppConstants.hostUrl}/sensor/find", data: reqData);
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Text('Selected Room Readings'),
                                        IconButton(onPressed: (){
                                          controller.removeFromFavorite();
                                          Navigator.of(context).pop();
                                        }, icon: Icon(Icons.star))
                                      ],
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("PIR Sensor: ${response.data["sensorData"]["motion"]}"),

                                        Text("Temperature: ${response.data["sensorData"]["temperature"]}")

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
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: 20
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(6)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Meeting room ${controller.favorites[index]["roomNumber"]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.star_border,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
              ],
            ),
          );
        }));
  }
}
