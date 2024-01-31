import 'package:bookingstore/AppColors.dart';
import 'package:bookingstore/app/modules/widgets/BottomNavBarWidget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
bottomNavigationBar: BottomNavBarWidget(currentIndex: 2,),
      body: GetBuilder<AccountController>(builder: (controller){
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Account Details",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40
              ),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("First Name"),
                  TextFormField(
                    controller: controller.firstName,
                    decoration: InputDecoration(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Last Name"),
                  TextFormField(
                    controller: controller.lastName,
                    decoration: InputDecoration(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email"),
                  TextFormField(
                    controller: controller.email,
                    decoration: InputDecoration(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone Number"),
                  TextFormField(
                    controller: controller.phoneNumber,
                    decoration: InputDecoration(
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
              GestureDetector(
                onTap:(){
                  controller.editAccount();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(10)),
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text("Save changes",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                ),
              ),
              GestureDetector(
                onTap:(){
                  controller.logout();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(10)),
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text("Log Out",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        );
      },)
    );
  }
}
