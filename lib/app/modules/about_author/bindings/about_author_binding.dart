import 'package:get/get.dart';

import '../controllers/about_author_controller.dart';

class AboutAuthorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutAuthorController>(
      () => AboutAuthorController(),
    );
  }
}
