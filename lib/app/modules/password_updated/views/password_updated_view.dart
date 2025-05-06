import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';
import '../controllers/password_updated_controller.dart';

class PasswordUpdatedView extends GetView<PasswordUpdatedController> {
  const PasswordUpdatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primarycolor,
      body: Stack(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: AppColor.backgroundGradient,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Password Updated',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9 - 50,
              decoration: BoxDecoration(
                color: AppColor.red,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 100, horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/updated-password.png'),
                      SizedBox(height: 50),
                      Text(
                        "Password Changed Successfully!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        " If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.white,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/login');
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: AppColor.backgroundGradient,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                              minHeight: 55,
                              maxWidth: double.infinity,
                            ),
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
