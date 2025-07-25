import 'package:get/get.dart';

import '../controllers/cproductdetails_controller.dart';

class CproductdetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CproductdetailsController>(
      () => CproductdetailsController(),
    );
  }
}
