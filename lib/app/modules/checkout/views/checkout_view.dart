import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buyzaars/app/modules/cart/controllers/cart_controller.dart';
// Update imports from letter_of_love to buyzaars
import 'package:buyzaars/utilities/colors.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  CheckoutView({super.key});
  //formkey
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primarycolor,
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.red,
        foregroundColor: AppColor.white,
      ),
      body: SingleChildScrollView(
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
                    color: Colors.black),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(
                    color: Color(0xFFB8B8B8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                style: TextStyle(
                  color: AppColor.black,
                ),
                keyboardType: TextInputType.name,
                validator: (value) =>
                    value!.isEmpty ? 'Name is required' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: "Your Email",
                  labelStyle: TextStyle(
                    color: Color(0xFFB8B8B8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                style: TextStyle(
                  color: AppColor.black,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? 'Email is required' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: controller.phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: TextStyle(
                    color: Color(0xFFB8B8B8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                style: TextStyle(
                  color: AppColor.black,
                ),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Phone number is required' : null,
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
                        labelStyle: TextStyle(
                          color: Color(0xFFB8B8B8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      style: TextStyle(
                        color: AppColor.black,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) =>
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
                        labelStyle: TextStyle(
                          color: Color(0xFFB8B8B8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      style: TextStyle(
                        color: AppColor.black,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) =>
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
                  labelStyle: TextStyle(
                    color: Color(0xFFB8B8B8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                style: TextStyle(
                  color: AppColor.black,
                ),
                keyboardType: TextInputType.text,
                validator: (value) =>
                    value!.isEmpty ? 'Country is required' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: controller.zipController,
                decoration: InputDecoration(
                  labelText: "Zip Code",
                  labelStyle: TextStyle(
                    color: Color(0xFFB8B8B8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                style: TextStyle(
                  color: AppColor.black,
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Zip code is required' : null,
              ),
              SizedBox(height: 15),
              // shipping address
              Text(
                'Shipping Address',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: controller.addressController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Address",
                  labelStyle: TextStyle(
                    color: Color(0xFFB8B8B8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                style: TextStyle(
                  color: AppColor.black,
                ),
                keyboardType: TextInputType.streetAddress,
                validator: (value) =>
                    value!.isEmpty ? 'Address is required' : null,
              ),
              SizedBox(height: 32),
              Text(
                'ADDITIONAL INFORMATION',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
              SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 20, left: 15, right: 15, bottom: 25),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColor.red, width: 1),
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
                      itemCount: Get.find<CartController>().cartItems.length,
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
                            ),
                          ),
                          trailing: Text(
                            "\$${totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.brown,
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
                          color: AppColor.red,
                          fontSize: 18,
                        ),
                      ),
                      trailing: Text(
                        "\$${Get.find<CartController>().totalPrice.value / 100}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Obx(
                      () => Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.createOrder();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.red,
                            minimumSize: Size(double.infinity, 50),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: controller.isLoading.value
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
      ),
    );
  }
}
