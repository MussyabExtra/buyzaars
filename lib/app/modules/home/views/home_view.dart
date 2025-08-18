import 'package:buyzaars/app/routes/app_pages.dart';
import 'package:buyzaars/utilities/colors.dart';
import 'package:buyzaars/app/modules/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:buyzaars/widgets/productDetailModal.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  //Scaffold Key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final BottomNavController bcontroller = Get.find<BottomNavController>();
  final items = [
    "assets/images/banner-1.webp",
    "assets/images/banner-2.webp",
    "assets/images/banner-3.webp",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        endDrawerEnableOpenDragGesture: false,
        key: scaffoldKey,
        appBar: AppBar(
            automaticallyImplyLeading: F,
            backgroundColor: AppColor.white,
            elevation: 15,
            // scrolledUnderElevation: 1.2,
            toolbarHeight: 60,
            shadowColor: AppColor.red.withOpacity(0.2),
            // surfaceTintColor: Colors.transparent,
            title: Image.asset("assets/images/logo.png", height: 40),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: AppColor.red,
                ),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
            ]),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                padding: EdgeInsets.fromLTRB(16, 40, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Welcome to Buyzaars',
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: Icon(Icons.home_outlined, color: AppColor.red),
                      title: Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Get.back();
                        bcontroller.tabIndex.value = 0;
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_bag_outlined,
                          color: AppColor.red),
                      title: Text(
                        'Shop',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Get.back();
                        bcontroller.tabIndex.value = 1;
                      },
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.category_outlined, color: AppColor.red),
                      title: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Get.back();
                        Get.toNamed('/all-categories');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person_outline, color: AppColor.red),
                      title: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Get.back();
                        bcontroller.tabIndex.value = 3;
                      },
                    ),
                    Divider(color: Colors.grey.withOpacity(0.3)),
                    ListTile(
                      leading: Icon(Icons.info_outline, color: AppColor.red),
                      title: Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Get.toNamed('/about-author');
                        // Handle About Us navigation
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.contact_support_outlined,
                          color: AppColor.red),
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Get.toNamed('/privacy-policy');
                        // Handle Contact Us navigation
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: FocusScope(
                    node: FocusScopeNode(),
                    child: GestureDetector(
                      onTap: () => Get.toNamed('/search-product'),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            hintStyle: TextStyle(
                              color: Color(0xFFB8B8B8),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xFFB8B8B8),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          style: TextStyle(
                            color: AppColor.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                cs.CarouselSlider.builder(
                  options: cs.CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1.0,
                    height: 220,
                    onPageChanged: (index, reason) =>
                        controller.currentBanner.value = index,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index, realIndex) => Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        top: 10, left: 15, right: 15, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        items[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: items.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => controller.currentBanner.value = entry.key,
                      child: Obx(() {
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 1.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (controller.currentBanner.value == entry.key)
                                ? AppColor.red
                                : AppColor.black,
                          ),
                        );
                      }),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 15, right: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shop By Category",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/all-categories');
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Obx(() {
                        if (controller.allcategories.isEmpty) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColor.black,
                            ),
                          );
                        }

                        // Take only first 5 categories
                        final displayCategories =
                            controller.allcategories.take(5).toList();

                        return Column(
                          children: [
                            // First row with 40-60 split
                            Row(
                              children: [
                                Expanded(
                                  flex: 4, // 40% width
                                  child: CategoryBox(
                                    title: displayCategories[0].name ?? '',
                                    image: displayCategories[0].image?.src ??
                                        'assets/images/placeholder.png',
                                    onTap: () {
                                      Get.toNamed(Routes.CATEGORY_PRODUCTS,
                                          arguments: {
                                            'categoryId':
                                                displayCategories[0].id,
                                            'categoryName':
                                                displayCategories[0].name,
                                          });
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 6, // 60% width
                                  child: CategoryBox(
                                    title: displayCategories[1].name ?? '',
                                    image: displayCategories[1].image?.src ??
                                        'assets/images/placeholder.png',
                                    onTap: () {
                                      Get.toNamed(Routes.CATEGORY_PRODUCTS,
                                          arguments: {
                                            'categoryId':
                                                displayCategories[1].id,
                                            'categoryName':
                                                displayCategories[1].name,
                                          });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            // Second row with three equal boxes
                            Row(
                              children: [
                                for (var i = 2; i < 5; i++) ...[
                                  if (i > 2) SizedBox(width: 10),
                                  Expanded(
                                    child: CategoryBox(
                                      title: displayCategories[i].name ?? '',
                                      image: displayCategories[i].image?.src ??
                                          'assets/images/placeholder.png',
                                      onTap: () {
                                        Get.toNamed(Routes.CATEGORY_PRODUCTS,
                                            arguments: {
                                              'categoryId':
                                                  displayCategories[i].id,
                                              'categoryName':
                                                  displayCategories[i].name,
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        );
                      }),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Latest Products",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              bcontroller.tabIndex.value = 1;
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 260,
                        child: Obx(() {
                          // Ensure the products list is loaded and not empty
                          if (controller.allproducts.isEmpty) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: AppColor.black,
                            ));
                          }
                          return ListView.builder(
                            // padding: EdgeInsets.only(top: 20),
                            shrinkWrap: true,
                            itemCount: controller.allproducts.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var product = controller.allproducts[index];
                              // print(product.images.first);
                              print(product.name);
                              print(product.variations);
                              print(product.price);
                              print(controller.allproducts.length);
                              if (controller.isLoading.value) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    top: 10, left: 2, right: 10, bottom: 6),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: GestureDetector(
                                  onTap: () => Get.toNamed(
                                    Routes.PRODUCTDETAILS,
                                    arguments: product,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: AppColor.red.withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                product.images[0].src
                                                    .toString()),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        width: 150,
                                        child: Text(
                                          product.name.toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColor.black,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "\$${product.price}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const CategoryBox({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: CachedNetworkImageProvider(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          padding: EdgeInsets.all(12),
          alignment: Alignment.bottomLeft,
          child: Html(
            data: title,
            style: {
              "body": Style(
                  color: Colors.white,
                  fontSize: FontSize(14),
                  fontWeight: FontWeight.bold,
                  textOverflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  padding: HtmlPaddings.zero),
            },
            shrinkWrap: true,
            // TextStyle(
            //   color: Colors.white,
            //   fontSize: 16,
            //   fontWeight: FontWeight.bold,
            // ),
          ),
        ),
      ),
    );
  }
}
