import 'package:bookingstore/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/placeholder.png"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email"),
                  TextFormField(
                    controller: controller.email,
                    decoration: InputDecoration(
                      labelText: 'Email...',
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
                  Text("Password"),
                  TextFormField(
                    controller: controller.password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password...',

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
                onTap:(){
                  controller.login();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(10)),
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text("Login",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ));
  }
}
