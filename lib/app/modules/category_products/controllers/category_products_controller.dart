import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buyzaars/api_key.dart';
import 'package:buyzaars/models/product.dart';
import 'package:buyzaars/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/utilities/local_db.dart';
import 'package:get/get.dart';

class CategoryProductsController extends GetxController {
  String? categoryId;
  String? categoryName;
  RxBool isLoading = false.obs;
  RxList<Product> products = <Product>[].obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print(Get.arguments['categoryId']);
    categoryId = Get.arguments['categoryId'].toString();
    categoryName = Get.arguments['categoryName'].toString();

    print(categoryId);
    fetchProductsByCategoryId();
  }

  Future<void> fetchProductsByCategoryId() async {
    try {
      isLoading.value = true;
      LocalDatabaseService _localDbService = LocalDatabaseService();
      String _token = await _localDbService.getSecurityToken();
      print('abc $_token');
      // https://marciaweis.com/wp-json/wc/v3/products/?category=18,15&consumer_key=ck_a6a812ed00990c5b8c15c0976ab70b8494935784&consumer_secret=cs_064b4e837aca34fe4389652686200ee8187ac1eb&per_page=100
      print(
          "${woocommerce.baseUrl}/wp-json/wc/v3/products/?category=$categoryId&consumer_key=${woocommerce.consumerKey}&consumer_secret=${woocommerce.consumerSecret}&per_page=100");
      final response = await http.get(
        Uri.parse(
            "${woocommerce.baseUrl}/wp-json/wc/v3/products/?category=$categoryId&consumer_key=${woocommerce.consumerKey}&consumer_secret=${woocommerce.consumerSecret}&per_page=100"),
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
}
