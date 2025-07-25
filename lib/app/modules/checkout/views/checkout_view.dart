import 'package:buyzaars/app/modules/cart/controllers/cart_controller.dart';
import 'package:buyzaars/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Update imports from letter_of_love to buyzaars
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  CheckoutView({super.key});
  //formkey
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isLoading.value) {
          // Prevent pop during payment
          Get.snackbar(
            "Please wait",
            "Payment is processing.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Checkout',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          centerTitle: true,
          backgroundColor: AppColor.red,
          foregroundColor: AppColor.white,
        ),
        body: Builder(
          builder: (context) {
           
            return SingleChildScrollView(
              padding: EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      'Billing Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColor.black,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(color: AppColor.black),
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 15,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      style: TextStyle(color: AppColor.black),
                      keyboardType: TextInputType.name,
                      validator:
                          (value) => value!.isEmpty ? 'Name is required' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        labelText: "Your Email",
                        labelStyle: TextStyle(color: AppColor.black),
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 15,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      style: TextStyle(color: AppColor.black),
                      keyboardType: TextInputType.emailAddress,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Email is required' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: controller.phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(color: AppColor.black),
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 15,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      style: TextStyle(color: AppColor.black),
                      keyboardType: TextInputType.phone,
                      validator:
                          (value) =>
                              value!.isEmpty
                                  ? 'Phone number is required'
                                  : null,
                    ),
                    SizedBox(height: 10),
                    // city, state and country
                    Row(
                      children: [
                        SizedBox(
                          width: 145,
                          child: TextFormField(
                            controller: controller.cityController,
                            decoration: InputDecoration(
                              labelText: "City",
                              labelStyle: TextStyle(color: AppColor.black),
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 15,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            style: TextStyle(color: AppColor.black),
                            keyboardType: TextInputType.text,
                            validator:
                                (value) =>
                                    value!.isEmpty ? 'City is required' : null,
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 150,
                          child: TextFormField(
                            controller: controller.stateController,
                            decoration: InputDecoration(
                              labelText: "State",
                              labelStyle: TextStyle(color: AppColor.black),
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 15,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                            style: TextStyle(color: AppColor.black),
                            keyboardType: TextInputType.text,
                            validator:
                                (value) =>
                                    value!.isEmpty ? 'State is required' : null,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    TextFormField(
                      controller: controller.countryController,
                      decoration: InputDecoration(
                        labelText: "Country",
                        labelStyle: TextStyle(color: AppColor.black),
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 15,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      style: TextStyle(color: AppColor.black),
                      keyboardType: TextInputType.text,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Country is required' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: controller.zipController,
                      decoration: InputDecoration(
                        labelText: "Zip Code",
                        labelStyle: TextStyle(color: AppColor.black),
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 15,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      style: TextStyle(color: AppColor.black),
                      keyboardType: TextInputType.number,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Zip code is required' : null,
                    ),
                    SizedBox(height: 15),
                    // shipping address
                    Text(
                      'Shipping Address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: controller.addressController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Address",
                        labelStyle: TextStyle(color: AppColor.black),
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 15,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      style: TextStyle(color: AppColor.black),
                      keyboardType: TextInputType.streetAddress,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Address is required' : null,
                    ),
                    SizedBox(height: 22),
                    Text(
                      'ADDITIONAL INFORMATION',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 22),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8),
                        // boxShadow: [
                        //   BoxShadow(color: Colors.black12, blurRadius: 4),
                        // ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 15,
                              right: 15,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColor.secondaryColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Text(
                              'YOUR ORDER',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColor.black,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                Get.find<CartController>().cartItems.length,
                            itemBuilder: (context, index) {
                              final cartItem =
                                  Get.find<CartController>().cartItems[index];
                              var totalPrice =
                                  double.parse(cartItem.price.toString()) / 100;
                              return ListTile(
                                title: Text(
                                  cartItem.name.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                    color: AppColor.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Text(
                                  "\$${totalPrice.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.black,
                                fontSize: 18,
                              ),
                            ),
                            trailing: Text(
                              "\$${Get.find<CartController>().totalPrice.value / 100}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColor.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 12.0,
                            ),
                            child: Obx(
                              () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select Payment Method',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildPaymentOption(
                                    title: 'Credit/Debit Card',
                                    value: 'card',
                                    groupValue: controller.paymentMethod.value,
                                    onChanged:
                                        (val) =>
                                            controller.paymentMethod.value =
                                                val!,
                                  ),
                                  const SizedBox(height: 12),
                                  _buildPaymentOption(
                                    title: 'Cash on Delivery',
                                    value: 'cash',
                                    groupValue: controller.paymentMethod.value,
                                    onChanged:
                                        (val) =>
                                            controller.paymentMethod.value =
                                                val!,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Obx(
                            () => Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 25,
                              ),
                              child: ElevatedButton(
                                onPressed:
                                    controller.isLoading.value
                                        ? null
                                        : () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await controller.placeOrder();
                                          }
                                        },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.red,
                                  minimumSize: Size(double.infinity, 50),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 30,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child:
                                    controller.isLoading.value
                                        ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                        : Text(
                                          'Place Order',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                   
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildPaymentOption({
  required String title,
  required String value,
  required String groupValue,
  required ValueChanged<String?> onChanged,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    color: Colors.grey[900],
    elevation: 3,
    child: ListTile(
      leading: Radio<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: AppColor.secondaryColor,
      ),
      title: Text(title, style: TextStyle(color: Colors.white)),
    ),
  );
}
