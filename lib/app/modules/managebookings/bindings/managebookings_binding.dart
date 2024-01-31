import 'package:get/get.dart';

import '../controllers/managebookings_controller.dart';

class ManagebookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagebookingsController>(
      () => ManagebookingsController(),
    );
  }
}
