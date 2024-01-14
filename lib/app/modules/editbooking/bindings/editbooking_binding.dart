import 'package:get/get.dart';

import '../controllers/editbooking_controller.dart';

class EditbookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditbookingController>(
      () => EditbookingController(),
    );
  }
}
