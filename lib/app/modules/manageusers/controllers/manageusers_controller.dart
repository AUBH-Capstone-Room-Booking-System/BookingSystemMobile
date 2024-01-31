import 'package:bookingstore/AppContants.dart';
import 'package:bookingstore/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ManageusersController extends GetxController {
bool isLoading=false;
var users=[];
var currentPage=0;

var formstate=FormState();
TextEditingController firstName=TextEditingController();
TextEditingController lastName=TextEditingController();
TextEditingController email=TextEditingController();
TextEditingController password=TextEditingController();

TextEditingController phoneNumber=TextEditingController();
TextEditingController major=TextEditingController();
var selectedUser=0;


var userTypes=["Admin","Client"];
var currentDropDownValue="Client";
switchPage(int index){
  currentPage=index;
  update();
}

createUser()async{
  print("clicked");
  Dio dio = Dio();
  try {

    var reqData = {
      "firstName":firstName.text,
      "lastName":lastName.text,
      "email": email.text,
      "phoneNumber":phoneNumber.text,
      "major":major.text,
      "password":password.text,
      "userType":currentDropDownValue,
    };
    var response =
    await dio.post("${AppConstants.hostUrl}/user/admin/add", data: reqData);

    switchPage(0);
    update();
    Get.snackbar("Success", "Successfully added account",  snackPosition: SnackPosition.BOTTOM);
    getAllUsers();
  } catch (error) {
    print('Error: $error');
  }
}

resetControlllers(){
  firstName.text="";
  lastName.text="";
  phoneNumber.text="";
  major.text="";
  email.text="";
  update();
}

selectUser(int index){
  selectedUser=users[index]["id"];
  firstName.text=users[index]["firstName"];
  lastName.text=users[index]["lastName"];

  email.text=users[index]["email"];
  phoneNumber.text=users[index]["phoneNumber"];
  major.text=users[index]["major"];
  currentDropDownValue=users[index]["userType"];

update();
}

  getAllUsers()async{
    Dio dio = Dio();

    try {
      isLoading=true;
      update();
      var response = await dio.get(
          "${AppConstants.hostUrl}/user/admin/findall");
      users.assignAll(response.data["users"]);
      isLoading=false;
      update();

    } catch (error) {
      print('Error: $error');
    }
  }

editAccount() async{
  Dio dio = Dio();
  try {

    var reqData = {
      "firstName":firstName.text,
      "lastName":lastName.text,
      "email": email.text,
      "phoneNumber":phoneNumber.text,
      "major":major.text,
      "userType":currentDropDownValue,
    };
    var response =
    await dio.post("${AppConstants.hostUrl}/user/admin/edit/${selectedUser}", data: reqData);

    switchPage(0);
    update();
    Get.snackbar("Success", "Successfully edited account",  snackPosition: SnackPosition.BOTTOM);
getAllUsers();
  } catch (error) {
    print('Error: $error');
  }
}

deleteAccount() async{
  Dio dio = Dio();
  try {
    var response =
    await dio.delete("${AppConstants.hostUrl}/user/admin/delete/${selectedUser}");

    switchPage(0);
    update();
    Get.snackbar("Success", "Successfully deleted account",  snackPosition: SnackPosition.BOTTOM);
getAllUsers();
  } catch (error) {
    print('Error: $error');
  }
}

  @override
  void onInit() {
    super.onInit();
    getAllUsers();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
