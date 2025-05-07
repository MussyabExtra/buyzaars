import 'package:buyzaars/utilities/colors.dart';
import 'package:buyzaars/app/modules/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buyzaars/widgets/productDetailModal.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final BottomNavController bcontroller = Get.find<BottomNavController>();
  final items = [
    "assets/images/banner-1.webp",
    "assets/images/banner-2.webp",
    "assets/images/banner-3.webp",
  ];
  final List<Map<String, dynamic>> products = [
    {
      "name": "The Great Gatsby",
      "price": "10.99",
      "image": "assets/images/Book-1.png",
    },
    {
      "name": "Becoming",
      "price": "19.99",
      "image": "assets/images/Book-3.png",
    },
    {
      "name": "Atomic Habits",
      "price": "15.99",
      "image": "assets/images/Book-2.png",
    },
    {
      "name": "Sapiens: A Brief History of Humankind",
      "price": "18.50",
      "image": "assets/images/Book-1.png",
    },
    {
      "name": "Educated",
      "price": "14.99",
      "image": "assets/images/Book-3.png",
    },
    {
      "name": "The Power of Now",
      "price": "12.99",
      "image": "assets/images/Book-2.png",
    },
    {
      "name": "The Catcher in the Rye",
      "price": "9.99",
      "image": "assets/images/Book-1.png",
    },
    {
      "name": "1984",
      "price": "13.99",
      "image": "assets/images/Book-3.png",
    },
    {
      "name": "The Alchemist",
      "price": "11.99",
      "image": "assets/images/Book-1.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColor.WhitebackgroundGradient,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 16,
                    right: 15,
                  ),
                  child: Text(
                    'Welcome! \nTo Buyzaars Store',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                  ),
                ),
                cs.CarouselSlider.builder(
                  options: cs.CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1.0,
                    height: 280,
                    onPageChanged: (index, reason) =>
                        controller.currentBanner.value = index,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index, realIndex) => Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        top: 25, left: 15, right: 15, bottom: 25),
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
                                : AppColor.white,
                          ),
                        );
                      }),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 15, right: 15, bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Latest Books",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              bcontroller.tabIndex.value = 1;
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 300,
                        child: Obx(() {
                          // Ensure the products list is loaded and not empty
                          if (controller.products.isEmpty) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: AppColor.red,
                            ));
                          }
                          return ListView.builder(
                            padding: EdgeInsets.only(top: 20),
                            shrinkWrap: true,
                            itemCount: controller.products.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var product = controller.products[index];
                              print(product.images[0].src);
                              print(product.name);
                              print(product.shortDescription);
                              print(product.price);
                              print(controller.products.length);
                              if (controller.isLoading.value) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    productDetailsModal(
                                      context: context,
                                      imageUrl: product.images[0].src,
                                      productName: product.name,
                                      productDescription: product.description,
                                      authorName: "Jack Ma",
                                      authorDescription:
                                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                                      price: "\$${product.price}",
                                      id: product.id,
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                product.images[0].src),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        width: 150,
                                        child: Text(
                                          product.name,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColor.white,
                                            fontWeight: FontWeight.bold,
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
                                          color: AppColor.red,
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
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shop By Category",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              bcontroller.tabIndex.value = 1;
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            flex: 4, // 40% width
                            child: CategoryBox(
                              title: "Coats & Jackets",
                              image: "assets/images/category-1.webp",
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 6, // 60% width
                            child: CategoryBox(
                              title: "Men's Fashion",
                              image: "assets/images/category-2.webp",
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CategoryBox(
                              title: "Casual Wear",
                              image: "assets/images/category-3.webp",
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CategoryBox(
                              title: "Watches",
                              image: "assets/images/category-4.webp",
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CategoryBox(
                              title: "Shoes",
                              image: "assets/images/category-5.webp",
                              onTap: () {},
                            ),
                          ),
                        ],
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
            image: AssetImage(image),
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
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
