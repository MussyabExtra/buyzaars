import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';

class RecoveryScreenView extends StatefulWidget {
  const RecoveryScreenView({super.key});

  @override
  State<RecoveryScreenView> createState() => _RecoveryScreenViewState();
}

class _RecoveryScreenViewState extends State<RecoveryScreenView> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

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
                'Change Password',
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),

                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColor.white,
                                  width: 1,
                                ),
                                color: Colors.transparent,
                              ),
                              child: Center(
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.key,
                                    size: 24,
                                    color: AppColor.black,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            // "Forgot Password" Text
                            Text(
                              "Change Password",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColor.white,
                              ),
                            ),

                            SizedBox(height: 5),

                            // Paragraph Text
                            Text(
                              "Your password length consists of 6-characters",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.white,
                              ),
                            ),

                            SizedBox(height: 30),

                            TextFormField(
                              controller: newPasswordController,
                              obscureText: obscurePassword,
                              decoration: InputDecoration(
                                labelText: "New Password",
                                labelStyle: TextStyle(
                                  color: Color(0xFFB8B8B8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 20),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    icon: Icon(
                                      obscurePassword
                                          ? Icons.remove_red_eye_outlined
                                          : Icons.remove_red_eye,
                                      color: AppColor.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        obscurePassword = !obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                color: AppColor.red,
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: confirmPasswordController,
                              obscureText: obscureConfirmPassword,
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                labelStyle: TextStyle(
                                  color: Color(0xFFB8B8B8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 20),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    icon: Icon(
                                      obscureConfirmPassword
                                          ? Icons.remove_red_eye_outlined
                                          : Icons.remove_red_eye,
                                      color: AppColor.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        obscureConfirmPassword =
                                            !obscureConfirmPassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                color: AppColor.red,
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Get.toNamed('/password-updated');
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
                                    "Save Password",
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
