import 'package:bookingstore/AppContants.dart';
import 'package:bookingstore/main.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {


  var favorites=[];
  var selectedFavorite=-1;
  var selectedFavoriteRoom=-1;
  var isLoading=false;
  getFavorites()async{
    print("getting favorites");
    Dio dio = Dio();

    try {
      var id =prefs.getInt("myId");
      var reqData={
        "userId":id,
      };
      isLoading=true;
      update();
      var response = await dio.post(
          "${AppConstants.hostUrl}/favorite/findall",data: reqData);
      favorites.assignAll(response.data["favorites"]);
      isLoading=false;
      update();

    } catch (error) {
      print('Error: $error');
    }
  }


  removeFromFavorite() async{
    Dio dio = Dio();

    try {
      var id=prefs.getInt("myId");
      var reqData = {
        "roomNumber":selectedFavoriteRoom,
        "userId": id,
      };
      print(reqData);
      var response =
      await dio.post("${AppConstants.hostUrl}/favorite/delete", data: reqData);
      Get.snackbar("Removed", "removed room from favorites!",snackPosition: SnackPosition.BOTTOM);
      print(selectedFavorite);
      favorites.removeAt(selectedFavorite);
      update();
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getFavorites();
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
