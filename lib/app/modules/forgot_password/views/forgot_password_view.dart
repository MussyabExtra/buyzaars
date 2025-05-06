import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController emailController = TextEditingController();
  bool isTextPresent = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {
        isTextPresent = emailController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Forgot Password',
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
                                  color: AppColor.red,
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
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            // "Forgot Password" Text
                            Text(
                              "Forgot Password",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColor.white,
                              ),
                            ),

                            SizedBox(height: 5),

                            // Paragraph Text
                            Text(
                              "A handful of model sentence structures",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.white,
                              ),
                            ),

                            SizedBox(height: 30),

                            // Existing Code: Email Input and Continue Button
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Please enter your email address. You will receive a link to reset your password.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Your Email",
                                hintStyle: TextStyle(
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
                                suffixIcon: isTextPresent
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: AppColor.red,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              emailController.clear();
                                              isTextPresent = false;
                                            });
                                          },
                                        ),
                                      )
                                    : null,
                              ),
                              style: TextStyle(
                                color: AppColor.red,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Get.toNamed('/recovery-screen');
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
                                    "Continue",
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
