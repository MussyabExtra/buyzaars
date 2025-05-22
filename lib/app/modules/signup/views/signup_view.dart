import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buyzaars/app/modules/signup/controllers/signup_controller.dart';
import '../../../../utilities/colors.dart';

class SignupView extends GetView<SignupController> {
  SignupView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
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
                'Sign Up',
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
                color: AppColor.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: controller.name.value,
                            decoration: InputDecoration(
                              labelText: "Your Name",
                              labelStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 15),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            style: TextStyle(
                              color: AppColor.black,
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: controller.email.value,
                            decoration: InputDecoration(
                              labelText: "Your Email",
                              labelStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 15),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            style: TextStyle(
                              color: AppColor.black,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Obx(
                            () => TextFormField(
                              controller: controller.password.value,
                              decoration: InputDecoration(
                                labelText: "Your Password",
                                labelStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                                filled: true,
                                fillColor: Colors.black12,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 20),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColor.red,
                                  ),
                                  onPressed: () {
                                    controller.togglePasswordVisibility();
                                  },
                                ),
                              ),
                              obscureText: !controller.isPasswordVisible.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                } else if (value.length < 8) {
                                  return "Password must be at least 8 characters long";
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: AppColor.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Obx(
                            () => ElevatedButton(
                              onPressed: controller.loader.value
                                  ? null // Disable button when loading
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        controller.createCustomer();
                                      }
                                    },
                              child: Ink(
                                width: double.infinity,
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
                                  child: controller.loader.value
                                      ? const SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          'Sign up',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                              style: ButtonStyle(
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.disabled)) {
                                        return const Color.fromARGB(
                                            255, 155, 97, 97);
                                      }
                                      return AppColor.black;
                                    },
                                  ),
                                  padding: WidgetStatePropertyAll(
                                      const EdgeInsets.all(0))),
                            ),
                          ),
                          SizedBox(height: 30),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    color: AppColor.black,
                                    
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    Get.offNamed('/login');
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: AppColor.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
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
        ],
      ),
    );
  }
}
