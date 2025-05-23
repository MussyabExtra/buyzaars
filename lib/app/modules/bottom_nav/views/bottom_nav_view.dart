import 'package:buyzaars/app/modules/account/views/account_view.dart';
import 'package:buyzaars/app/modules/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:buyzaars/app/modules/cart/controllers/cart_controller.dart';
import 'package:buyzaars/app/modules/cart/views/cart_view.dart';
import 'package:buyzaars/app/modules/home/controllers/home_controller.dart';
import 'package:buyzaars/app/modules/home/views/home_view.dart';
import 'package:buyzaars/app/modules/search_product/views/search_product_view.dart';
import 'package:buyzaars/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavView extends GetView<BottomNavController> {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);
  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12);

  buildBottomNavigationMenu(context, controller) {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => CartController());
    selectedLabelStyle.copyWith(color: AppColor.red);
    return Obx(
      () => Container(
        height: 70,
        padding: EdgeInsets.only(top: 8, bottom: 10),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.red.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, -3), // changes position of shadow
            ),
          ],
        ),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Wrap(children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 700),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 0.1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                   key: ValueKey<int>(controller.tabIndex.value),
                  showUnselectedLabels: true,
                  showSelectedLabels: true,
                  onTap: controller.changeTabIndex,
                  currentIndex: controller.tabIndex.value,
                  backgroundColor: AppColor.white,
                  unselectedItemColor: AppColor.red.withOpacity(0.4),
                  selectedItemColor: AppColor.red,
                  unselectedLabelStyle: unselectedLabelStyle,
                  selectedLabelStyle: selectedLabelStyle,
                  items: [
                    BottomNavigationBarItem(
                      icon: Container(
                        margin: EdgeInsets.only(bottom: 7),
                        child: Icon(
                          Icons.home,
                          size: 20.0,
                        ),
                      ),
                      label: 'Home',
                      backgroundColor: AppColor.secondaryColor,
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        margin: EdgeInsets.only(bottom: 7),
                        child: Icon(
                          Icons.book,
                          size: 20.0,
                        ),
                      ),
                      label: 'Products',
                      //backgroundColor: AppColor.red,
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        margin: EdgeInsets.only(bottom: 7),
                        child: Icon(
                          Icons.shopping_cart,
                          size: 20.0,
                        ),
                      ),
                      label: 'Cart',
                      //backgroundColor: AppColor.red,
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        margin: EdgeInsets.only(bottom: 7),
                        child: Icon(
                          Icons.person,
                          size: 20.0,
                        ),
                      ),
                      label: 'Profile',
                      //backgroundColor: AppColor.red,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final LandingPageController landingPageController =
    //     Get.put(LandingPageController(), permanent: false);
    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      // bottomOpacity: 0,
      // toolbarHeight: 0,
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: AppColor.WhitebackgroundGradient.colors.first, // Status bar
      // ),
      // ),

      backgroundColor: AppColor.white,
      bottomNavigationBar: buildBottomNavigationMenu(context, controller),
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            HomeView(),
            SearchProductView(),
            CartView(),
            AccountView(),
          ],
        ),
      ),
    );
  }
}
