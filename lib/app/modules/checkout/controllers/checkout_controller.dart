import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/order_payload.dart';
import 'package:get/get.dart';
import 'package:buyzaars/api_key.dart';
import 'package:buyzaars/app/modules/cart/controllers/cart_controller.dart';
import 'package:buyzaars/utilities/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Update imports from letter_of_love to buyzaars

class CheckoutController extends GetxController {
  // late dynamic homeController = Get.find<HomeController>(). ?? {};
  // late dynamic cartController = Get.find<CartController>().?? {};
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();
  var zipController = TextEditingController();
  RxBool isLoading = false.obs;
  var customerId = 0.obs;
  final count = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('userrecord') ?? '';
    final homeController = jsonDecode(jsonData);
    //homeController = Get.find<HomeController>().retrievedData;

    nameController.text = homeController['username'] ?? '';
    emailController.text = homeController['email'] ?? '';
    customerId.value = homeController['id'] ?? '';
    print('Customer ID: ${customerId.value}');
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> createOrder() async {
    print("Creating Order");
    isLoading.value = true;
    try {
      var cartItems = Get.find<CartController>().cartItems;
      // Create an order in WooCommerce
      final lineItems = cartItems.map((item) {
        return LineItems(
          productId:
              item.id, // Assuming you have a productId in your WooCartItems
          quantity: item.quantity,
          total: (item.linePrice! / 100)
              .toString(), // Assuming you have a totalPrice field
          // subtotal: {item.linePrice.toString()}, // Assuming you have a price field
        );
      }).toList();

      final response = await woocommerce.createOrder(
        WooOrderPayload(
          paymentMethod: 'cash',
          paymentMethodTitle: 'Cash on Delivery',
          setPaid: false,
          status: 'processing',
          shipping: WooOrderPayloadShipping(
            firstName: nameController.text,
            lastName: '',
            address1: addressController.text,
            city: cityController.text,
            state: stateController.text,
          ),
          billing: WooOrderPayloadBilling(
            firstName: nameController.text,
            lastName: '',
            address1: addressController.text,
            city: cityController.text,
            state: stateController.text,
            phone: phoneController.text,
            email: emailController.text,
            country: countryController.text,
          ),
          lineItems: [
            // add cart items
            ...lineItems
          ],
          customerId: customerId.value,
        ),
      );
      isLoading.value = false;
      print("Order Created: $response");
      Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          elevation: 5,
          backgroundColor: AppColor.white,
          title: Text('Order Placed',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColor.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/images/cele.json',
                width: 150,
                height: 150,
              ),
              Text(
                "Your order has been placed successfully.",
                style: TextStyle(color: AppColor.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SelectableText(
                "Your Order# is: ${response.orderKey}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () async {
                    await woocommerce.deleteAllMyCartItems();
                    cartItems.clear();
                    nameController.clear();
                    emailController.clear();
                    Get.offAllNamed("/bottom-nav");
                  },
                  child: Text(
                    'Continue Shopping',
                    style: TextStyle(
                        color: AppColor.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      print('Error creating order: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
