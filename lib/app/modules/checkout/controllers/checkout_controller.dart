import 'dart:convert';
import 'package:buyzaars/api_key.dart';
import 'package:buyzaars/app/modules/cart/controllers/cart_controller.dart';
import 'package:buyzaars/app/routes/app_pages.dart';
import 'package:buyzaars/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/utilities/local_db.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Update imports from letter_of_love to buyzaars
import 'package:flutter_stripe/flutter_stripe.dart';


class CheckoutController extends GetxController {


  // ... (other fields)
  final RxBool _continueShoppingLoading = false.obs;

  bool get isContinueShoppingLoading => _continueShoppingLoading.value;
  void setContinueShoppingLoading(bool val) {
    _continueShoppingLoading.value = val;
    update(['continueShoppingBtn']);
  }

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
  RxString paymentMethod = 'card'.obs; // 'card' or 'cash'

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
    customerId.value = int.tryParse(homeController['id'].toString()) ?? 0;
    print('Customer ID: ${customerId.value}');
  }




  Future<void> placeOrder() async {
    try {
      isLoading.value = true;
      LocalDatabaseService _localDbService = LocalDatabaseService();
      String? authToken = await _localDbService.getSecurityToken();
      final cartItems = Get.find<CartController>().cartItems;
      final lineItems = cartItems.map((item) {
        return {
          "product_id": item.id,
          "quantity": item.quantity,
          "total": (item.linePrice! / 100).toStringAsFixed(2),
        };
      }).toList();

      final billing = {
        "first_name": nameController.text,
        "last_name": "",
        "address_1": addressController.text,
        "address_2": "",
        "city": cityController.text,
        "state": stateController.text,
        "postcode": zipController.text,
        "country": countryController.text,
        "email": emailController.text,
        "phone": phoneController.text,
      };
      final shipping = {
        "first_name": nameController.text,
        "last_name": "",
        "address_1": addressController.text,
        "address_2": "",
        "city": cityController.text,
        "state": stateController.text,
        "postcode": zipController.text,
        "country": countryController.text,
      };

      // Card/Stripe payment flow
      if (paymentMethod.value == 'card') {
        final response = await http.post(
          Uri.parse('${woocommerce.baseUrl}/wp-json/wc/v3/orders?consumer_key=${woocommerce.consumerKey}&consumer_secret=${woocommerce.consumerSecret}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            "payment_method": "card",
            "payment_method_title": "Card Payment",
            "set_paid": false,
            "status": "pending",
            "customer_id": customerId.value,
            "billing": billing,
            "shipping": shipping,
            "line_items": lineItems,
          }),
        );
        if (response.statusCode == 201) {
          final orderData = jsonDecode(response.body);
          final orderId = orderData['id'];
          final amountInCents = ((double.tryParse(orderData['total']?.toString() ?? '0') ?? 0) * 100).toInt();
          await startStripeCheckout(orderId, amountInCents);
        } else {
          Get.snackbar(
            "Order Failed",
            "Unable to place order. Please try again later.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        // Cash on Delivery flow
        final response = await http.post(
          Uri.parse('${woocommerce.baseUrl}/wp-json/wc/v3/orders?consumer_key=${woocommerce.consumerKey}&consumer_secret=${woocommerce.consumerSecret}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            "payment_method": "cash",
            "payment_method_title": "Cash on Delivery",
            "set_paid": false,
            "status": "pending",
            "customer_id": customerId.value,
            "billing": billing,
            "shipping": shipping,
            "line_items": lineItems,
          }),
        );
        if (response.statusCode == 201) {
          final orderData = jsonDecode(response.body);
          final orderId = orderData['id'];
          Get.dialog(
            barrierDismissible: false,
            AlertDialog(
              elevation: 5,
              backgroundColor: AppColor.white,
              title: Text('Order Placed', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset('assets/images/cele.json', width: 200, height: 200),
                  Text("Your order has been placed successfully.", style: TextStyle(color: AppColor.black), textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  SelectableText("Your Order# is: $orderId", textAlign: TextAlign.center, style: TextStyle(color: AppColor.red, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250,
                    child: GetBuilder<CheckoutController>(
                      id: 'continueShoppingBtn',
                      builder: (ctrl) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          onPressed: ctrl.isContinueShoppingLoading ? null : () async {
                            ctrl.setContinueShoppingLoading(true);
                            try {
                              await woocommerce.deleteAllMyCartItems();
                              cartItems.clear();
                              nameController.clear();
                              emailController.clear();
                              Get.offAllNamed(Routes.BOTTOM_NAV);
                            } finally {
                              ctrl.setContinueShoppingLoading(false);
                            }
                          },
                          child: ctrl.isContinueShoppingLoading
                              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2))
                              : Text('Continue Shopping', style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          Get.snackbar(
            "Order Failed",
            "Unable to place order. Please try again later.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      print('Checkout error: $e');
      Get.snackbar(
        "Error",
        "Unable to place order. Please try again later.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Stripe PaymentSheet logic using Firebase Function
  Future<void> startStripeCheckout(int orderId, int amountInCents) async {
    try {
      final cartItems = Get.find<CartController>().cartItems;
      // 1. Call your Firebase Function to get client secret
      final response = await http.post(
        Uri.parse("https://stripe-backend-roan-eight.vercel.app/api/create-payment-intent"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "amount": amountInCents,
          "orderId": orderId,
        }),
      );
      final clientSecret = jsonDecode(response.body)["clientSecret"];
      // 2. Initialize the Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Buyzaars',
        ),
      );
      // 3. Present the Payment Sheet
      await Stripe.instance.presentPaymentSheet();
      // 4. On success, mark WooCommerce order as paid
      await updateWooOrderAsPaid(orderId);
      // Get.snackbar("Payment Success", "Your order has been paid successfully.");
      Get.dialog(
            barrierDismissible: false,
            AlertDialog(
              elevation: 5,
              backgroundColor: AppColor.white,
              title: Text('Order Placed', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset('assets/images/cele.json', width: 200, height: 200),
                  Text("Your order has been placed successfully.", style: TextStyle(color: AppColor.black), textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  SelectableText("Your Order# is: $orderId", textAlign: TextAlign.center, style: TextStyle(color: AppColor.red, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 250,
                    child: GetBuilder<CheckoutController>(
                      id: 'continueShoppingBtn',
                      builder: (ctrl) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          onPressed: ctrl.isContinueShoppingLoading ? null : () async {
                            ctrl.setContinueShoppingLoading(true);
                            try {
                              await woocommerce.deleteAllMyCartItems();
                              cartItems.clear();
                              nameController.clear();
                              emailController.clear();
                              Get.offAllNamed(Routes.BOTTOM_NAV);
                            } finally {
                              ctrl.setContinueShoppingLoading(false);
                            }
                          },
                          child: ctrl.isContinueShoppingLoading
                              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2))
                              : Text('Continue Shopping', style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
    } catch (e) {
      print('Stripe Error: $e');
      Get.snackbar(
        "Payment Failed",
        "Unable to complete payment. Please try again later.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateWooOrderAsPaid(int orderId) async {
    final response = await http.put(
      Uri.parse('${woocommerce.baseUrl}/wp-json/wc/v3/orders/$orderId?consumer_key=${woocommerce.consumerKey}&consumer_secret=${woocommerce.consumerSecret}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "set_paid": true,
        "status": "processing",
      }),
    );
    print('WooCommerce Order Update: ${response.statusCode}');
  }
}
