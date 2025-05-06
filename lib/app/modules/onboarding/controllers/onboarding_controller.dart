// Update imports from letter_of_love to buyzaars
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:buyzaars/app/modules/onboarding/views/splash_view.dart';

// ignore: deprecated_member_use
class OnboardingController extends GetxController
    // ignore: deprecated_member_use
    with
        SingleGetTickerProviderMixin {
  late TabController tabController;
  RxInt currentIndex = 0.obs; // Observable variable to track the current index

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      currentIndex.value =
          tabController.index; // Update current index when tab changes
    });
    super.onInit();
  }

  void completeOnboarding() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isFirstTime', false);
    Get.offAll(() => SplashView()); // Redirect to login after onboarding
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
