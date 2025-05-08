import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
}) {
  final BottomNavController bcontroller = Get.find<BottomNavController>();
  return showModalBottomSheet(
    backgroundColor: AppColor.white,
    barrierColor: Colors.red.withOpacity(0.5),
    isScrollControlled: true,
    enableDrag: true,
    useSafeArea: true,
    showDragHandle: true,
    sheetAnimationStyle: AnimationStyle(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ),
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
                      // Row(
                      //   children: [
                      //     RatingBarIndicator(
                      //       rating: 4.0,
                      //       itemBuilder: (context, index) => const Icon(
                      //         Icons.star,
                      //         color: Colors.amber,
                      //       ),
                      //       itemCount: 5,
                      //       itemSize: 20,
                      //       direction: Axis.horizontal,
                      //     ),
                      //     const SizedBox(width: 4),
                      //     const Text(
                      //       '(4.0)',
                      //       style: TextStyle(
                      //         fontSize: 12,
                      //         color: AppColor.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 20),
                      // Text(
                      //   "About Author: ",
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // SizedBox(height: 10),
                      // Text(
                      //   authorDescription,
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     color: Colors.black,
                      //   ),
                      //   maxLines: 5,
                      //   overflow: TextOverflow.ellipsis,
                      //   textAlign: TextAlign.left,
                      //   softWrap: true,
                      // ),
                      // GestureDetector(
                      //   onTap: () => Get.toNamed("/about-author"),
                      //   child: Text(
                      //     'Read More',
                      //     style: TextStyle(
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.bold,
                      //       color: AppColor.black,
                      //       decoration: TextDecoration.combine(
                      //           [TextDecoration.underline]),
                      //       decorationStyle: TextDecorationStyle.solid,
                      //       decorationColor: Colors.black,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 20),
                      SizedBox(width: 10),
                      Text(
                        price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.red,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed:
                                      Get.find<CartController>().loader.value
                                          ? null // Disable button when loading
                                          : () {
                                              Get.find<CartController>()
                                                  .addToCart(id.toString());
                                            },
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
                                    minimumSize: Size(double.infinity, 55),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 25),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              bcontroller.tabIndex(2);
                            },
                            child: Text(
                              "View Cart",
                              style: TextStyle(
                                color: AppColor.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
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
