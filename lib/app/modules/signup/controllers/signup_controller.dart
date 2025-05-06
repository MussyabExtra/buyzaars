import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/customer.dart';
import 'package:get/get.dart';
import 'package:buyzaars/api_key.dart';
import 'package:buyzaars/utilities/colors.dart';

class SignupController extends GetxController {
  var isPasswordVisible = false.obs;
  final name = TextEditingController().obs;
  final email = TextEditingController().obs;
  final password = TextEditingController().obs;
  RxBool loader = false.obs;
  WooCustomer? user;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void createCustomer() async {
    loader.value = true;
    if (name.value.text.isNotEmpty &&
        email.value.text.isNotEmpty &&
        password.value.text.isNotEmpty) {
      user = WooCustomer(
        username: name.value.text,
        password: password.value.text,
        email: email.value.text,
      );

      try {
        final result = await woocommerce.createCustomer(user!);
        Get.snackbar("Account Created", "Proceed to Login",
            backgroundColor: AppColor.red, colorText: Colors.white);
        print("Retrieved Data: $result");
        Get.toNamed('/login');
        // Reset input fields and stop loader
        name.value.clear();
        email.value.clear();
        password.value.clear();
      } catch (e) {
        String errorMessage = "An error occurred. Please try again later.";
        if (e is Exception) {
          print("Error caught: $e");
          if (e.toString().contains('registration-error-username-exists')) {
            errorMessage =
                "Username already exists. Please choose a different one.";
            name.value.clear();
          } else if (e.toString().contains('email_exists')) {
            errorMessage =
                "Email already registered. Please use a different email.";
            email.value.clear();
          } else if (e.toString().contains('message:')) {
            final message =
                RegExp(r"message: (.*)").firstMatch(e.toString())?.group(1);
            if (message != null) {
              errorMessage = message;
            }
          } else {
            errorMessage = "Error: ${e.toString()}";
          }
        } else {
          errorMessage = "Unexpected error: ${e.toString()}";
        }
        Get.snackbar("Error", errorMessage,
            backgroundColor: AppColor.white,
            duration: const Duration(seconds: 5),
            colorText: AppColor.red);
        print("Error creating customer: $e");
      } finally {
        loader.value = false;
      }
    }
  }
}
