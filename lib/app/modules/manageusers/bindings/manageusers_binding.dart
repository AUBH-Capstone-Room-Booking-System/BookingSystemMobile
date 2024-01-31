import 'package:get/get.dart';

import '../controllers/manageusers_controller.dart';

class ManageusersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageusersController>(
      () => ManageusersController(),
    );
  }
}
