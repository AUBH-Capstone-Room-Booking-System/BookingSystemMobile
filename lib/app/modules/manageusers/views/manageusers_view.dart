import 'package:bookingstore/AppColors.dart';
import 'package:bookingstore/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/manageusers_controller.dart';

class ManageusersView extends GetView<ManageusersController> {
  const ManageusersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: GetBuilder<ManageusersController>(builder: (controller){
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if(controller.currentPage==0){
                          Get.back();

                        }else{
                          print("this case");
                          controller.resetControlllers();
                          controller.switchPage(0);

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
                Expanded(child:

                IndexedStack(
                  index: controller.currentPage,
                  children: [
                    controller.isLoading?Center(child:
                    CircularProgressIndicator(),):Column(
                      children: [
                        Text(
                          "Users",
                          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.users.length,
                              itemBuilder: (BuildContext context, int index) {

                                return Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.mainColor!,width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                              children: [
                                                TextSpan(
                                                  text: '${controller.users[index]["firstName"]} ${controller.users[index]["lastName"]}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                    16.0, // Adjust the font size as needed
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' - ${controller.users[index]["userType"]}',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(controller.users[index]["email"]),
                                        ],
                                      ),
                                      IconButton(onPressed: (){


                                          controller.selectUser(index);
                                          controller.switchPage(1);

                                      }, icon:Icon(FontAwesomeIcons.ellipsisVertical))
                                    ],
                                  ),
                                );
                              },
                            )),
                        GestureDetector(
                          onTap:(){
                            controller.switchPage(2);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(10)),
                            width: Get.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text("Add User",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                    ListView(

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

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Password"),
                            TextFormField(
                              obscureText: true,
                              controller: controller.password,
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
                            Text("Major"),
                            TextFormField(
                              controller: controller.major,
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
                            Text("User Type"),
                            DropdownButton(
                              isExpanded: true,
                              items:
                              controller.userTypes.map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,),).toList(),
                              onChanged: (val) {

                                  controller.currentDropDownValue = val!;
                                  controller.update();
                              },
                              value: controller.currentDropDownValue,
                            )
                          ],
                        ),
                        SizedBox(height: 10,),

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
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap:(){
                            controller.deleteAccount();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(10)),
                            width: Get.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text("Delete Account",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("New User",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40
                        ),),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
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
                                    Text("Password"),
                                    TextFormField(
                                      obscureText: true,
                                      controller: controller.password,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Major"),
                                    TextFormField(
                                      controller: controller.major,
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
                                    Text("User Type"),
                                    DropdownButton(
                                      isExpanded: true,
                                      items:
                                      controller.userTypes.map((e) => DropdownMenuItem(
                                        child: Text("$e"),
                                        value: e,),).toList(),
                                      onChanged: (val) {

                                        controller.currentDropDownValue = val!;
                                        controller.update();
                                      },
                                      value: controller.currentDropDownValue,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            controller.createUser();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(10)),
                            width: Get.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text("Create User",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                          ),
                        ),

                      ],
                    ),
                  ],
                ))
              ],
            ),
          );
        },)

    );
  }
}
