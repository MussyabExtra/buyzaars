import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
import 'package:buyzaars/app/modules/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:buyzaars/app/modules/cart/controllers/cart_controller.dart';
import 'package:buyzaars/utilities/colors.dart';

productDetailsModal({
  required id,
  required BuildContext context,
  required String imageUrl,
  required String productName,
  required String productDescription,
  required String price,
  required List<int>? variation,
  required List<WooProductItemAttribute> attribute,
}) {
  final BottomNavController bcontroller = Get.find<BottomNavController>();

  // Create RxString for selected attribute values
  final selectedAttributes = <String, RxString>{};

  // Initialize selected values for each attribute
  for (var attr in attribute) {
    selectedAttributes[attr.name!] = ''.obs;
  }

  return showModalBottomSheet(
    backgroundColor: AppColor.white,
    barrierColor: Colors.red.withOpacity(0.5),
    isScrollControlled: true,
    enableDrag: true,
    useSafeArea: true,
    showDragHandle: true,
    context: context,
    builder: (context) {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          height: 300,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        productName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.red,
                          fontSize: 25,
                        ),
                      ),
                      Html(
                          data: productDescription.isEmpty
                              ? "No description available"
                              : productDescription,
                          style: {
                            "body": Style(
                              color: AppColor.black,
                              fontSize: FontSize(12),
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w400,
                              padding: HtmlPaddings(
                                left: HtmlPadding.zero(),
                                right: HtmlPadding.zero(),
                                top: HtmlPadding.zero(),
                                bottom: HtmlPadding.zero(),
                              ),
                            ),
                          }),

                      SizedBox(height: 15),
                      // Add Attribute Selection
                      if (attribute.isNotEmpty) ...[
                        Text(
                          'Available Options',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.red,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        ...attribute
                            .map((attr) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      attr.name ?? '',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.black,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: attr.options
                                                ?.map(
                                                  (option) =>
                                                      Obx(() => GestureDetector(
                                                            onTap: () {
                                                              selectedAttributes[
                                                                      attr.name!]
                                                                  ?.value = option;
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal: 16,
                                                                vertical: 8,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: selectedAttributes[attr.name!]
                                                                            ?.value ==
                                                                        option
                                                                    ? AppColor
                                                                        .red
                                                                    : Colors.grey[
                                                                        200],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child: Text(
                                                                option,
                                                                style:
                                                                    TextStyle(
                                                                  color: selectedAttributes[attr.name!]
                                                                              ?.value ==
                                                                          option
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                )
                                                .toList() ??
                                            [],
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                  ],
                                ))
                            .toList(),
                      ],
                      Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validate if all attributes are selected for variable products
                                    if (attribute.isNotEmpty) {
                                      bool allSelected = attribute.every(
                                          (attr) =>
                                              selectedAttributes[attr.name!]
                                                  ?.value
                                                  .isNotEmpty ??
                                              false);

                                      if (!allSelected) {
                                        Get.snackbar(
                                          'Selection Required',
                                          'Please select an Variation',
                                          backgroundColor: AppColor.red,
                                          colorText: Colors.white,
                                        );
                                        return;
                                      }
                                    }

                                    if (!Get.find<CartController>()
                                        .loader
                                        .value) {
                                      Get.find<CartController>().addToCart(
                                          productId: id.toString(),
                                          variation: selectedAttributes.values
                                                  .map((value) => value.value)
                                                  .toList()
                                              as List<WooProductVariation>?);
                                    }
                                  },
                                  // onPressed:
                                  //     Get.find<CartController>().loader.value
                                  //         ? null // Disable button when loading
                                  //         : () {
                                  //             Get.find<CartController>()
                                  //                 .addToCart(id.toString());
                                  //           },
                                  child: Get.find<CartController>().loader.value
                                      ? const SizedBox(
                                          height: 10,
                                          width: 10,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 0.5,
                                            color: Colors.black,
                                          ),
                                        )
                                      : Ink(
                                          decoration: BoxDecoration(
                                            gradient:
                                                AppColor.backgroundGradient,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            alignment: Alignment.center,
                                            constraints: BoxConstraints(
                                              minHeight: 55,
                                              maxWidth: double.infinity,
                                            ),
                                            child: Text(
                                              "Add to Cart",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              bcontroller.tabIndex(2);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              decoration: BoxDecoration(
                                gradient: AppColor.backgroundGradient,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    color: AppColor.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
