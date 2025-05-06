import 'package:get/get.dart';

import '../controllers/recovery_screen_controller.dart';

class RecoveryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecoveryScreenController>(
      () => RecoveryScreenController(),
    );
  }
}
