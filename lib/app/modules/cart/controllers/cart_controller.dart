import 'dart:convert';
import 'package:buyzaars/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/product_variation.dart';
import 'package:flutter_wp_woocommerce/utilities/local_db.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
// Update imports from letter_of_love to buyzaars
import 'package:buyzaars/api_key.dart';
import 'package:buyzaars/models/cartmodel.dart';
import 'package:buyzaars/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  var cartItems = <WooCartItems>[].obs; // Observing cart items
  var totalPrice = 0.0.obs; // Observing total price
  var isLoading = false.obs; // For showing loading indicators
  RxBool isvarloading = false.obs;
  RxBool loader = false.obs;

  @override
  void onInit() {
    fetchCartItems();
    super.onInit();
  }

  getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

//clear cart

  // Add product to cart

  // Fetch cart items
  Future<void> fetchCartItems() async {
    try {
      isLoading.value = true;
      final String token = await getTokenFromSharedPreferences();
      final response = await http.get(
        Uri.parse('${woocommerce.baseUrl}/wp-json/wc/store/cart/items'),
        headers: {'Authorization': 'Bearer ${token}'},
      );

      if (response.statusCode == 200) {
        // Parse the response body as a List
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        // Map the List into WooCartItems
        cartItems.value = jsonResponse
            .map((item) => WooCartItems.fromJson(item as Map<String, dynamic>))
            .toList();

        // Calculate the total price manually since it's a flat list
        totalPrice.value = cartItems.fold(
            0.0,
            (sum, item) =>
                sum + (item.linePrice ?? 0)); // Use linePrice for totals
      } else {
        print("Error fetching cart items: ${response.body}");
      }
    } catch (e) {
      print(woocommerce.authToken);
      print("Error fetching cart items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Add product to cart
  Future<void> addToCart(
      {String? productId, List<Map<String, dynamic>>? variation}) async {
    try {
      final String token = await getTokenFromSharedPreferences();
      print("Token: $token");
      print("Adding to cart: $productId");
      print("Variations: $variation");
      isLoading.value = true;
      loader.value = true;
      // if (cartItems.any((item) => item.id == int.parse(productId!))) {
      //   Get.snackbar("Sorry", "You can't add the same product twice.",
      //       backgroundColor: AppColor.red, colorText: Colors.white);

      //   return;
      // }
      await woocommerce.addToMyCart(
          itemId: productId.toString(), quantity: '1',);
      await fetchCartItems();
      Get.back();
      Get.snackbar("Added to Cart", "Product added to cart successfully.",
          backgroundColor: AppColor.red, colorText: Colors.white);
    } catch (e) {
      print("Error adding to cart: $e");
    } finally {
      isLoading.value = false;
      loader.value = false;
    }
  }

  // Remove item from cart
  Future<void> removeFromCart(String key) async {
    try {
      print("Removing from cart: $key");
      isLoading.value = true;
      await woocommerce.deleteMyCartItem(key: key);
      await fetchCartItems(); // Refresh cart after removal
    } catch (e) {
      print("Error removing from cart: $e");
    } finally {
      isLoading.value = false;
    }
  }

Future<void> updateCartItemQuantity(
      String key, int quantity, int id) async {
    try {
      isLoading.value = true;
      await woocommerce.updateMyCartItemByKey(key: key, id: id, quantity: quantity);
      await fetchCartItems(); // Refresh cart after updating
    } catch (e) {
      print("Error updating cart item: $e");
    } finally {
      isLoading.value = false;
    }
  }


Future<void> addToCartWithVariation({
  required String productId,
  List<Map<String, dynamic>>? variation,
}) async {
  try {
      LocalDatabaseService _localDbService = LocalDatabaseService();
    String? authToken = await _localDbService.getSecurityToken();
    isLoading.value = true;
    loader.value = true;

    final response = await http.post(
      Uri.parse('${woocommerce.baseUrl}/wp-json/wc/store/cart/add-item'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({
        'id': productId,
        'quantity': 1,
        'variation': variation, 
      })
    );
    print('Response status: ${response.statusCode}');
    // await woocommerce.addToMyCart(
    //   itemId: productId,
    //   quantity: '1',
    //   variations: variation,
    // );

    await fetchCartItems();
    Get.back();
    Get.snackbar("Added", "Product added to cart successfully.",
        backgroundColor: AppColor.red, colorText: Colors.white);
  } catch (e) {
    print("Cart error: $e");
  } finally {
    isLoading.value = false;
    loader.value = false;
  }
}

  Future<WooProductVariation?> fetchMatchingVariation({
  required int productId,
  required List<int> variationIds,
  required Map<String, String> selectedAttributes,
}) async {
  try{
    isvarloading.value = true;
  for (int varId in variationIds) {
    final response = await http.get(Uri.parse('https://buyzaars.com/wp-json/wc/v3/products/$productId/variations/$varId?consumer_key=${woocommerce.consumerKey}&consumer_secret=${woocommerce.consumerSecret}'));
    print('Fetching variation with: https://buyzaars.com/wp-json/wc/v3/products/$productId/variations/$varId?consumer_key=${woocommerce.consumerKey}&consumer_secret=${woocommerce.consumerSecret}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final variation = WooProductVariation.fromJson(data);
      print('Variation data: $data');

      // Match selected attributes
      bool isMatch = variation.attributes.every((attr) {
        return selectedAttributes[attr.name?.toLowerCase()]?.toLowerCase() == attr.option?.toLowerCase();
      });

      if (isMatch) {
        return variation;
      }
    }
  }
  } catch (e) {
    print("Error fetching variation: $e");
  } finally {
    isvarloading.value = false;
  }
  return null;
}

}
