import 'package:bookingstore/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reset_controller.dart';

class ResetView extends GetView<ResetController> {
  const ResetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:GetBuilder<ResetController>(builder: (controller){
        return Container(
          padding: EdgeInsets.all(20),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Trouble logging in?",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40
              ),),
              Text("Enter your email and enter your new password to reset it!"),
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
                      // Optionally add padding to the border
                      // contentPadding: EdgeInsets.all(8.0),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("New Password"),
                  TextFormField(
                    controller: controller.firstPassword,
                    obscureText: controller.obscureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: () {
                        controller.obscureText=!controller.obscureText;
                        controller.update();
                      }, icon: Icon(controller.obscureText?Icons.remove_red_eye:Icons.remove_red_eye_outlined),

                      ), // Add your suffix icon here
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Confirm New Password"),
                  TextFormField(
                    controller: controller.secondPassword,
                    obscureText: controller.obscureText,

                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: () {
                        controller.obscureText=!controller.obscureText;
                        controller.update();
                      }, icon: Icon(controller.obscureText?Icons.remove_red_eye:Icons.remove_red_eye_outlined),),
                      border: OutlineInputBorder(
                        // Set the border width and color
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.blue,
                        ),
                        // Set the border radius
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),

                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap:(){
                  controller.confirm();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(10)),
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text("Confirm",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        );
      },)
    );
  }
}
