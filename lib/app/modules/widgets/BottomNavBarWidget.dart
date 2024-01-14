import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({Key? key,required this.currentIndex}) : super(key: key);
final currentIndex;
  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: widget.currentIndex,
      items: [
      BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_today),label: "Calendar"),
      BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined),label: "Account"),


    ],onTap: (index){
      if(index==0){
        Get.toNamed("/");

      }else if( index==1){
        Get.toNamed("/calendar");

      }else{
        Get.toNamed("/account");

      }
    },

    );
  }
}
