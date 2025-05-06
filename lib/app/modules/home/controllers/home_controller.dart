import 'dart:convert';

import 'package:buyzaars/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/utilities/local_db.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:buyzaars/api_key.dart';
// Update imports from letter_of_love to buyzaars
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utilities/colors.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  var products = <Product>[].obs;
  Map<String, dynamic>? retrievedData;
  var currentBanner = 0.obs;

  void onInit() async {
    await getDataFromSharedPreferences();
    fetchProductsByCategoryId();
    super.onInit();
  }

  Future<void> logUserOut() async {
    try {
      await woocommerce.logUserOut();
    } catch (e) {
      print("Error invalidating token: $e");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userrecord');
    await prefs.remove('token');
    Get.snackbar("Logout Successful", "You have been logged out.",
        backgroundColor: AppColor.red, colorText: Colors.white);
    Get.offAllNamed('/login');
  }

  Future<void> fetchProductsByCategoryId() async {
    try {
      isLoading.value = true;
      LocalDatabaseService _localDbService = LocalDatabaseService();
      String _token = await _localDbService.getSecurityToken();
      print('abc $_token');
      // https://marciaweis.com/wp-json/wc/v3/products/?category=18,15&consumer_key=ck_a6a812ed00990c5b8c15c0976ab70b8494935784&consumer_secret=cs_064b4e837aca34fe4389652686200ee8187ac1eb&per_page=100
      print(
          "${woocommerce.baseUrl}/wp-json/wc/v3/products/?category=15,15&consumer_key=${woocommerce.consumerKey}&consumer_secret=${woocommerce.consumerSecret}&per_page=100");
      final response = await http.get(
        Uri.parse(
            "${woocommerce.baseUrl}/wp-json/wc/v3/products/?category=18,15&consumer_key=ck_a6a812ed00990c5b8c15c0976ab70b8494935784&consumer_secret=cs_064b4e837aca34fe4389652686200ee8187ac1eb&per_page=100"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        List<Product> productlist = (data as List)
            .map((productJson) => Product.fromJson(productJson))
            .toList();

        products.value = productlist;
        print('abc $products');
      } else {
        print("Failed to fetch products: ${response.statusCode}");
      }
    } catch (e) {
      // print(e.toString());
      Get.snackbar("Error", 'Check your internet connection',
          backgroundColor: AppColor.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('userrecord') ?? '';
    retrievedData = jsonDecode(jsonData);
    print("Retrieved Data: $retrievedData");
  }
}
