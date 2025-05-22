import 'package:buyzaars/widgets/productDetailModal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../../utilities/colors.dart';
import '../controllers/category_products_controller.dart';

class CategoryProductsView extends GetView<CategoryProductsController> {
  const CategoryProductsView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryProductsController());
    print(controller.categoryId);
    return Scaffold(
      appBar: AppBar(
        title: Html(
          data: controller.categoryName.toString(),
          style: {
            "body": Style(
              fontSize: FontSize(16.0),
              color: AppColor.white,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.ellipsis
            ),

          },
          shrinkWrap: T,
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
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            if (controller.products.isEmpty) {
              return Column(
                children: [
                  SizedBox(height: 180),
                  Center(
                    child: Text(
                      "No products found",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ],
              );
            }
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.6,
                ),
                padding: EdgeInsets.only(top: 5),
                shrinkWrap: true,
                itemCount: controller.products.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  String imageUrl = '';
                  if (product.images.isNotEmpty) {
                    imageUrl = product.images.first.src
                        .toString(); // Get the first image URL
                  }
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10),
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
                      onTap: () {
                        print(product.description.toString());
                        productDetailsModal(
                          context: context,
                          imageUrl: product.images[0].src.toString(),
                          productName: product.name.toString(),
                          productDescription: product.description.toString(),
                          price: product.price.toString(),
                          id: product.id,
                          variation: product.variations,
                          attribute: product.attributes,
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: AppColor.red.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    product.images[0].src.toString()),
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
                });
          }),

          // ... existing code ...

// ... existing code ...,
        ),
      ),
    );
  }
}
