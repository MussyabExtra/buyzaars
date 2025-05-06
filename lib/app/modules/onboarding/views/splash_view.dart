import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:buyzaars/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends GetView {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset("assets/images/splash_screen.webp",
                fit: BoxFit.fill),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('isFirstTime', false);
                        Get.toNamed('/signup');
                      },
                      child: const Text(
                        ' Sign up',
                        style: TextStyle(
                          color: AppColor.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(children: [
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 100.0, right: 10.0),
                        child: const Divider(
                          color: Colors.white,
                          height: 22,
                        )),
                  ),
                  const Text(
                    'Or login with',
                    style: TextStyle(color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 100.0),
                        child: const Divider(
                          color: Colors.white,
                          height: 22,
                        )),
                  ),
                ]),
                IconButton(
                  icon: const Icon(
                    Icons.login,
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isFirstTime', false);
                    Get.toNamed('/login');
                  },
                  iconSize: 40,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
