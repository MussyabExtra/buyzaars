import 'dart:math';

import 'package:buyzaars/app/modules/home/controllers/home_controller.dart';
import 'package:buyzaars/app/modules/home/views/home_view.dart';
import 'package:buyzaars/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utilities/colors.dart';
import '../controllers/all_categories_controller.dart';

class AllCategoriesView extends GetView<AllCategoriesController> {
  const AllCategoriesView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
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
            icon: Icon(Icons.arrow_back, color: AppColor.white)),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.white,
        ),
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: // ... existing code ...
              Obx(() {
            if (controller.allcategories.isEmpty) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.black,
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (controller.allcategories.length / 5).ceil(),
              itemBuilder: (context, groupIndex) {
                final startIndex = groupIndex * 5;
                final remainingItems =
                    controller.allcategories.length - startIndex;

                return Column(
                  children: [
                    if (remainingItems > 0) ...[
                      // First row with 40-60 split
                      Row(
                        children: [
                          Expanded(
                            flex: 4, // 40% width
                            child: CategoryBox(
                              title:
                                  controller.allcategories[startIndex].name ??
                                      '',
                              image: controller
                                      .allcategories[startIndex].image?.src ??
                                  'assets/images/placeholder.png',
                              onTap: () {
                                Get.toNamed(Routes.CATEGORY_PRODUCTS,
                                    arguments: {
                                      'categoryId': controller
                                          .allcategories[startIndex].id,
                                      'categoryName': controller
                                          .allcategories[startIndex].name,
                                    });
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          if (remainingItems > 1)
                            Expanded(
                              flex: 6, // 60% width
                              child: CategoryBox(
                                title: controller
                                        .allcategories[startIndex + 1].name ??
                                    '',
                                image: controller.allcategories[startIndex + 1]
                                        .image?.src ??
                                    'assets/images/placeholder.png',
                                onTap: () {
                                  Get.toNamed(Routes.CATEGORY_PRODUCTS,
                                      arguments: {
                                        'categoryId': controller
                                            .allcategories[startIndex + 1].id,
                                        'categoryName': controller
                                            .allcategories[startIndex + 1]
                                            .name,
                                      });
                                },
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Second row with three equal boxes
                      if (remainingItems > 2)
                        Row(
                          children: [
                            for (var i = 2;
                                i < min(5, remainingItems);
                                i++) ...[
                              if (i > 2) SizedBox(width: 10),
                              Expanded(
                                child: CategoryBox(
                                  title: controller
                                          .allcategories[startIndex + i].name ??
                                      '',
                                  image: controller
                                          .allcategories[startIndex + i]
                                          .image
                                          ?.src ??
                                      'assets/images/placeholder.png',
                                  onTap: () {
                                    Get.toNamed(Routes.CATEGORY_PRODUCTS,
                                        arguments: {
                                          'categoryId': controller
                                              .allcategories[startIndex + i].id,
                                          'categoryName': controller
                                              .allcategories[startIndex + i]
                                              .name,
                                        });
                                  },
                                ),
                              ),
                            ],
                          ],
                        ),
                    ],
                    if (groupIndex <
                        (controller.allcategories.length / 5).ceil() - 1)
                      SizedBox(height: 10),
                  ],
                );
              },
            );
          }),
// ... existing code ...,
        ),
      ),
    );
  }
}
