import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utilities/colors.dart';
import '../controllers/success_purchased_controller.dart';

class SuccessPurchasedView extends GetView<SuccessPurchasedController> {
  const SuccessPurchasedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primarycolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          elevation: 0,
          centerTitle: false,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: AppColor.backgroundGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Successfully Purchased',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image
              Image.asset('assets/images/successfully-purchased.png'),

              SizedBox(height: 50),
              Text(
                "Successfully Purchased",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
              ),

              // Warning message

              // Spacing before the button
              SizedBox(height: 30),

              // Continue Button
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/signup');
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
    );
  }
}
