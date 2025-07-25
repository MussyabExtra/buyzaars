import 'dart:convert';
import 'package:buyzaars/api_key.dart';
import 'package:buyzaars/models/cartmodel.dart';
import 'package:buyzaars/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/product_variation.dart';
import 'package:flutter_wp_woocommerce/utilities/local_db.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Update imports from letter_of_love to buyzaars


class CartController extends GetxController {
  var cartItems = <WooCartItems>[].obs; // Observing cart items
  var totalPrice = 0.0.obs; // Observing total price
  var isLoading = false.obs; // For showing loading indicators
  RxBool loader = false.obs;
  // Per-item loading state for increment, decrement, and delete
  RxMap<String, bool> itemLoading = <String, bool>{}.obs;

  @override
  void onInit() {
    fetchCartItems();
    super.onInit();
  }

  getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Add product to cart

  // Fetch cart items
  Future<void> fetchCartItems() async {
    try {
      isLoading.value = true;
      final String token = await getTokenFromSharedPreferences();
      final response = await http.get(
        Uri.parse('${woocommerce.baseUrl}/wp-json/wc/store/cart/items'),
        headers: {'Authorization': 'Bearer $token'},
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


  Future<void> clearCart() async {
    try {
      isLoading.value = true;
      final String token = await getTokenFromSharedPreferences();
      final response = await http.delete(
        Uri.parse('${woocommerce.baseUrl}/wp-json/wc/store/cart/items'),
        headers: {'Authorization': 'Bearer $token'},
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
      // Get.back();
      Get.snackbar("Added to Cart", "Product added to cart successfully.",
          backgroundColor: AppColor.red, colorText: Colors.white);
    } catch (e) {
      print("Error adding to cart: $e");
       //out of stock
       if(e.toString().contains("out of stock")){
        Get.snackbar("Out of Stock", "Product is out of stock.",
            backgroundColor: Colors.red, colorText: Colors.white);
       }
    } finally {
      isLoading.value = false;
      loader.value = false;
    }
  }

  // Remove item from cart
  Future<void> removeFromCart(String key) async {
    try {
      print("Removing from cart: $key");
      itemLoading[key] = true;
      await woocommerce.deleteMyCartItem(key: key);
      await fetchCartItems(); // Refresh cart after removal
    } catch (e) {
      print("Error removing from cart: $e");
       //out of stock
       if(e.toString().contains("out of stock")){
        Get.snackbar("Out of Stock", "Product is out of stock.",
            backgroundColor: Colors.red, colorText: Colors.white);
       }
    } finally {
      itemLoading[key] = false;
    }
  }

Future<void> updateCartItemQuantity(
      String key, int quantity, int id) async {
    try {
      itemLoading[key] = true;
      await woocommerce.updateMyCartItemByKey(key: key, id: id, quantity: quantity);
      await fetchCartItems(); // Refresh cart after updating
    } catch (e) {
      print("Error updating cart item: $e");
    } finally {
      itemLoading[key] = false;
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
    if(response.statusCode == 200 || response.statusCode == 201){
      await fetchCartItems();
    // Get.back();
    Get.snackbar("Added", "Product added to cart successfully.",
        backgroundColor: AppColor.red, colorText: Colors.white);
    } else {
      Get.snackbar("Error", "Failed to add product to cart.",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    print('Response status: ${response.body}');
    // await woocommerce.addToMyCart(
    //   itemId: productId,
    //   quantity: '1',
    //   variations: variation,
    // );

  } catch (e) {
    print("Cart error: $e");
    
  } finally {
    isLoading.value = false;
    loader.value = false;
  }
}

  

}
