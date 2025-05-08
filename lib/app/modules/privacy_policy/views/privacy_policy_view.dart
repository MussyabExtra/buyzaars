import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utilities/colors.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '• Consent\n\n'
                'By using our application, you hereby consent to our Privacy Policy and agree to its terms.\n\n'
                '• Information we collect\n\n'
                'The personal information that you are asked to provide, and the reasons why you are asked to provide it, will be made clear to you at the point we ask you to provide your personal information.\n\n'
                'If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide.\n\n'
                'When you register for an Account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number.\n\n'
                '• How we use your information\n\n'
                'We use the information we collect in various ways, including to:\n\n'
                '• Provide, operate, and maintain our website\n'
                '• Improve, personalize, and expand our website\n'
                '• Understand and analyze how you use our website\n'
                '• Develop new products, services, features, and functionality\n'
                '• Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the website, and for marketing and promotional purposes\n'
                '• Send you emails\n'
                '• Find and prevent fraud',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.black,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
