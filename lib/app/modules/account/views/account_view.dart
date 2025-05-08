import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buyzaars/app/modules/home/controllers/home_controller.dart';
import '../../../../utilities/colors.dart';
import '../controllers/account_controller.dart';

// ignore: must_be_immutable
class AccountView extends GetView<AccountController> {
  AccountView({super.key});
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Account',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          // leading: IconButton(
          //   onPressed: () => Get.back(),
          //   icon: Icon(Icons.arrow_back, color: AppColor.white),
          // ),
          centerTitle: false,
          backgroundColor: AppColor.red,
          foregroundColor: AppColor.white,
        ),
        body: Container(
          height: double.infinity,
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: AppColor.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/profile.png')
                            as ImageProvider,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/my-orders');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Text(
                              'My Orders',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: AppColor.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColor.primarycolor,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/profile');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: AppColor.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColor.primarycolor,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/about-author');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Text(
                              'About',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: AppColor.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColor.primarycolor,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/privacy-policy');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Text(
                              'Privacy Policy',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: AppColor.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColor.primarycolor,
                    ),
                    GestureDetector(
                      onTap: () {
                        //pop up to logout
                        Get.defaultDialog(
                          radius: 12,
                          title: 'Logout',
                          titleStyle: TextStyle(color: Colors.black),
                          content: Text(
                            'Are you sure you want to logout?',
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text('Yes',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                onPressed: () {
                                  homeController.logUserOut();
                                }),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text('Cancel',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColor.white,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: AppColor.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
