import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
import 'package:buyzaars/api_key.dart';
// Update imports from letter_of_love to buyzaars
import 'package:buyzaars/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  RxBool loader = false.obs;
  final email = TextEditingController().obs;
  final password = TextEditingController().obs;

  void onInit() {
    super.onInit();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> saveDataToSharedPreferences(dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(data);
    await prefs.setString('userrecord', jsonData);
  }

  void saveTokenToSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  void loginCustomer() async {
    loader.value = true;
    if (email.value.text.isNotEmpty && password.value.text.isNotEmpty) {
      try {
        final token = await woocommerce.authenticateViaJWT(
          username: email.value.text,
          password: password.value.text,
        );
        if (token != null) {
          saveTokenToSharedPreferences(token);
          print("Access Token: $token");
        } else {
          Get.snackbar("Error", "JWT login failed. Trying customer login...",
              backgroundColor: AppColor.red, colorText: Colors.white);
        }
        final customer = await woocommerce.loginCustomer(
          username: email.value.text,
          password: password.value.text,
        );

        if (customer != null) {
          saveDataToSharedPreferences(customer);
          Get.snackbar(
              "Login Successful", "Welcome back, ${customer.username}!",
              backgroundColor: AppColor.red, colorText: Colors.white);
          print("Logged in User: ${customer.username}");

          Get.offAllNamed('/bottom-nav');
        } else {
          Get.snackbar("Error", "Invalid credentials. Please try again.",
              backgroundColor: AppColor.red, colorText: Colors.white);
        }
      } catch (e) {
        String errorMessage = "An error occurred. Please try again later.";
        if (e is WooCommerceError) {
          print("Error caught: $e");
          if (e.message ==
              'Unknown email address. Check again or try your username.') {
            errorMessage =
                "Email address is not registered. Please check or sign up.";
            email.value.clear();
            password.value.clear();
          } else if (e.message ==
              '<strong>Error:</strong> The password you entered for the email address <strong>random@gmsol.com</strong> is incorrect. <a href="https://authorbillblackford.com/my-account/lost-password/">Lost your password?</a>') {
            errorMessage =
                "The password you entered for the email address ${email.value.text} is incorrect.";
            password.value.clear();
          } else if (e.message != null) {
            errorMessage = e.message!;
          } else {
            errorMessage = "Login Error: ${e.message ?? 'Unknown error'}";
          }
        } else {
          errorMessage = "Unexpected error: ${e.toString()}";
        }
        Get.snackbar("Error", errorMessage,
            backgroundColor: AppColor.red, colorText: Colors.white);
        print("Error logging in: $e");
      } finally {
        loader.value = false;
      }
    }
  }
}
