import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/customer.dart';
import 'package:get/get.dart';
import 'package:buyzaars/api_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utilities/colors.dart';
// Update imports from letter_of_love to buyzaars

class ProfileController extends GetxController {
  RxBool isPLoading = false.obs;
  //formkey
  final formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    isPLoading.value = true;

    try {
      // Retrieve customer data from shared preferences (if needed for updating)
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonData = prefs.getString('userrecord') ?? '';

      if (jsonData.isEmpty) {
        Get.snackbar("Error", "No customer data found. Please log in first.",
            backgroundColor: AppColor.red);
        return;
      }

      // Parse the customer data (assuming it's saved as JSON)
      final customerData = WooCustomer.fromJson(jsonDecode(jsonData));

      // Prepare the data for updating the password
      Map<String, dynamic> data = {
        'email': customerData.email, // Customer email (required for updating)
        'password': newPassword, // New password
      };

      // Call the updateCustomer function to update the password
      final updatedCustomer =
          await woocommerce.updateCustomer(id: customerData.id!, data: data);

      // Handle the response
      // Optionally, you can update shared preferences with the updated data
      await saveDataToSharedPreferences(updatedCustomer);
      Get.back();
      // Success message
      Get.snackbar("Success", "Password updated successfully.",
          backgroundColor: AppColor.red);
    } catch (e) {
      // Handle any errors
      String errorMessage =
          "An error occurred while updating the password. Please try again later.";
      if (e is Exception) {
        errorMessage = "Error: ${e.toString()}";
      }

      Get.snackbar("Error", errorMessage, backgroundColor: Colors.red);
      print("Error updating password: $e");
    } finally {
      isPLoading.value = false;
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    }
  }

  // Save updated customer data to shared preferences
  Future<void> saveDataToSharedPreferences(WooCustomer data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(data.toJson());
    await prefs.setString('userrecord', jsonData);
  }
}
