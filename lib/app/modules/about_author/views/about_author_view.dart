import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';
import '../controllers/about_author_controller.dart';

class AboutAuthorView extends GetView<AboutAuthorController> {
  AboutAuthorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColor.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.red,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: AppColor.white),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    SizedBox(height: 6),
                    Text(
                      'Buyzaars Store',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'At Buy Zaars, we are redefining the online shopping experience by offering a comprehensive platform where you can find everything you need in one place. From stylish apparel to fresh groceries, cutting-edge electronics, and daily essentials, we cater to a wide variety of customer needs. Our goal is to make shopping more convenient, efficient, and enjoyable by providing high-quality products at competitive prices, backed by exceptional service.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Our journey began with a simple mission: to create a marketplace that prioritizes customer satisfaction while offering unparalleled value. Over the years, we’ve grown into a trusted destination for shoppers, thanks to our commitment to quality, reliability, and innovation. Every product on Buy Zaars is carefully curated to meet the highest standards, ensuring our customers always receive the best. At the heart of Buy Zaars is a team of dedicated professionals who strive to enhance your shopping experience. With fast and secure delivery options, user-friendly website navigation, and round-the-clock customer support, we make shopping stress-free and rewarding. Whether you’re stocking up on household items or exploring the latest trends, Buy Zaars is here to simplify your life and exceed your expectations.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
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
