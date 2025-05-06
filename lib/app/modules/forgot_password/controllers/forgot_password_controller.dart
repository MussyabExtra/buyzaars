import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  var emailText = ''.obs;

  var isTextPresent = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updateEmailText(String text) {
    emailText.value = text;
    isTextPresent.value = text.isNotEmpty;
  }

  void clearEmailText() {
    emailText.value = '';
    isTextPresent.value = false;
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
