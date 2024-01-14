import 'package:bookingstore/AppColors.dart';
import 'package:bookingstore/app/modules/editbooking/controllers/editbooking_controller.dart';
import 'package:bookingstore/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';
late SharedPreferences prefs;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance(); // Initialize prefs
  Get.put(EditbookingController());
  Get.put(FavoritesController());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primaryColor: AppColors.mainColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.mainColor!,
          // ···
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.mainColor!, // Change the cursor color here
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mainColor!), // Change the border color here
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mainColor!), // Change the border color here
          ),
          // Customize other properties as needed
        ),
      ),
    ),
  );
}
