import 'package:get/get.dart';

import '../controllers/success_purchased_controller.dart';

class SuccessPurchasedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessPurchasedController>(
      () => SuccessPurchasedController(),
    );
  }
}
