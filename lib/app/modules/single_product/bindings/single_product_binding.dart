import 'package:get/get.dart';

import '../controllers/single_product_controller.dart';

class SingleProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleProductController>(
      () => SingleProductController(),
    );
  }
}
