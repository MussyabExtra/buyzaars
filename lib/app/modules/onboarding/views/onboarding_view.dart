import '../../../../utilities/colors.dart';
import 'package:buyzaars/widgets/custom_tab_page_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image(
              image: AssetImage('assets/images/onboarding-3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          // Overlay
          Positioned.fill(
            child: Container(
              color: AppColor.black.withOpacity(0.8),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      // First Onboarding Screen
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/logo.png'),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Welcome to Buyzaars",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppColor.white),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s .",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      // Second Onboarding Screen
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/logo.png'),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Welcome to Buyzaars",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppColor.white),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s .",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      // Third Onboarding Screen
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/logo.png'),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Welcome to Buyzaars",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppColor.white),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s .",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomTabPageSelector(controller: controller.tabController),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 30.0),
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: controller.currentIndex.value == 0
                              ? null
                              : () {
                                  controller.tabController.animateTo(
                                    (controller.tabController.index - 1)
                                        .clamp(0, 2),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primarycolor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16.0),
                                bottomRight: Radius.circular(16.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Previous',
                            style: TextStyle(
                              color: AppColor.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (controller.currentIndex.value == 2) {
                              controller.completeOnboarding();
                            } else {
                              controller.tabController.animateTo(
                                (controller.tabController.index + 1)
                                    .clamp(0, 2),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.red,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                bottomLeft: Radius.circular(16.0),
                              ),
                            ),
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                            child: Text(
                              controller.currentIndex.value == 2
                                  ? 'Finish'
                                  : 'Next',
                              key: ValueKey<String>(
                                  controller.currentIndex.value == 2
                                      ? 'Finish'
                                      : 'Next'),
                              style: TextStyle(
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 65, right: 20),
              child: Obx(
                () {
                  double progress = (controller.currentIndex.value + 1) / 3;
                  return GestureDetector(
                    onTap: () {
                      controller.completeOnboarding();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: AppColor.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(AppColor.red),
                            strokeWidth: 3,
                          ),
                          Icon(
                            CupertinoIcons.forward,
                            color: AppColor.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
