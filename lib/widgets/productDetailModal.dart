// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_wp_woocommerce/models/products.dart';
// import 'package:flutter_wp_woocommerce/woocommerce.dart';
// import 'package:get/get.dart';
// import 'package:buyzaars/app/modules/bottom_nav/controllers/bottom_nav_controller.dart';
// import 'package:buyzaars/app/modules/cart/controllers/cart_controller.dart';
// import 'package:buyzaars/utilities/colors.dart';

// productDetailsModal({
//   required id,
//   required BuildContext context,
//   required String imageUrl,
//   required String productName,
//   required String productDescription,
//   required String price,
//   required List<int>? variation,
//   required List<WooProductItemAttribute> attribute,
// }) {
//   final BottomNavController bcontroller = Get.find<BottomNavController>();
//   final CartController cartController = Get.find<CartController>();

//   print('variation: $variation');
//   print('attribute: $attribute');

//   // Create RxString for selected attribute values
//   final selectedAttributes = <String, RxString>{};

//   // Initialize selected values for each attribute
//   for (var attr in attribute) {
//     selectedAttributes[attr.name!] = ''.obs;
//   }

//   Rx<WooProductVariation?> selectedVariation = Rx<WooProductVariation?>(null);
//   RxString currentPrice = price.obs;

//   void updateSelectedVariation() async {
//     if (variation != null) {
//       Map<String, String> selectedAttr = {};
//       selectedAttributes.forEach((key, value) {
//         selectedAttr[key.toLowerCase()] = value.value;
//       });

//       var matchedVar = await cartController.fetchMatchingVariation(
//         productId: id,
//         variationIds: variation,
//         selectedAttributes: selectedAttr,
//       );

//       if (matchedVar != null) {
//         selectedVariation.value = matchedVar;
//         currentPrice.value = matchedVar.price!;
//       }
//     }
//   }

//   return showModalBottomSheet(
//     backgroundColor: AppColor.white,
//     barrierColor: Colors.black12.withOpacity(0.5),
//     isScrollControlled: true,
//     enableDrag: true,
//     useSafeArea: true,
//     showDragHandle: true,
//     context: context,
//     builder: (context) {
//       return Container(
//         clipBehavior: Clip.hardEdge,
//         decoration: BoxDecoration(
//           color: AppColor.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Align(
//                         alignment: Alignment.center,
//                         child: CachedNetworkImage(
//                           imageUrl:  imageUrl,
//                           fit: BoxFit.cover,
//                           height: 300,
//                           placeholder: (context, url) => Container(
//                             height: 300,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: AppColor.red.withOpacity(0.05),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: const Center(
//                               child: CircularProgressIndicator( 
//                                 color: AppColor.red,
//                                 strokeWidth: 0.3,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         productName,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: AppColor.black,
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Obx(() {
//                         return cartController.isvarloading.value
//                             ?  Container(
//                                 margin: EdgeInsets.all(10),
//                                 height: 10,
//                                 width: 10,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 0.5,
//                                   color: Colors.black,
//                                 ),
//                               )
//                             : Text(
//                                 '\$${currentPrice.value}',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: AppColor.red,
//                                   fontSize: 25,
//                                 ),
//                               );
//                       }),
//                       Html(
//                           data: productDescription.isEmpty
//                               ? "No description available"
//                               : productDescription,
//                           style: {
//                             "body": Style(
//                               color: AppColor.black,
//                               fontSize: FontSize(12),
//                               textAlign: TextAlign.start,
//                               fontWeight: FontWeight.w400,
//                               padding: HtmlPaddings(
//                                 left: HtmlPadding.zero(),
//                                 right: HtmlPadding.zero(),
//                                 top: HtmlPadding.zero(),
//                                 bottom: HtmlPadding.zero(),
//                               ),
//                             ),
//                           }),

//                       SizedBox(height: 15),
//                       // Add Attribute Selection
//                       if (attribute.isNotEmpty &&
//                           variation != [] &&
//                           variation != null &&
//                           variation.isNotEmpty) ...[
//                         Text(
//                           'Available Options',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: AppColor.red,
//                             fontSize: 18,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         ...attribute
//                             .map((attr) => Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       attr.name ?? '',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: AppColor.black,
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     SingleChildScrollView(
//                                       scrollDirection: Axis.horizontal,
//                                       child: Row(
//                                         children: attr.options
//                                                 ?.map(
//                                                   (option) =>
//                                                       Obx(() => GestureDetector(
//                                                             onTap: cartController
//                                                                     .isvarloading
//                                                                     .value
//                                                                 ? null
//                                                                 : () {
//                                                                     selectedAttributes[attr.name!]!
//                                                                             .value =
//                                                                         option;
//                                                                     updateSelectedVariation();
//                                                                   },
//                                                             child: Container(
//                                                               margin: EdgeInsets
//                                                                   .only(
//                                                                       right:
//                                                                           10),
//                                                               padding: EdgeInsets
//                                                                   .symmetric(
//                                                                 horizontal: 16,
//                                                                 vertical: 8,
//                                                               ),
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 color: selectedAttributes[attr.name!]
//                                                                             ?.value ==
//                                                                         option
//                                                                     ? AppColor
//                                                                         .red
//                                                                     : Colors.grey[
//                                                                         200],
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             20),
//                                                               ),
//                                                               child: Text(
//                                                                 option,
//                                                                 style:
//                                                                     TextStyle(
//                                                                   color: selectedAttributes[attr.name!]
//                                                                               ?.value ==
//                                                                           option
//                                                                       ? Colors
//                                                                           .white
//                                                                       : Colors
//                                                                           .black,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           )),
//                                                 )
//                                                 .toList() ??
//                                             [],
//                                       ),
//                                     ),
//                                     SizedBox(height: 16),
//                                   ],
//                                 ))
//                             .toList(),
//                       ],
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Obx(
//                               () => SizedBox(
//                                 height: 50,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     if (attribute.isNotEmpty &&
//                                         variation != [] &&
//                                         variation != null &&
//                                         variation.isNotEmpty) {
//                                       bool allSelected = attribute.every(
//                                         (attr) =>
//                                             selectedAttributes[attr.name!]
//                                                 ?.value
//                                                 .isNotEmpty ??
//                                             false,
//                                       );

//                                       if (!allSelected ||
//                                           selectedVariation.value == null) {
//                                         Get.snackbar('Error',
//                                             'Please select a valid variation',
//                                             backgroundColor: AppColor.red,
//                                             colorText: Colors.white);
//                                         return;
//                                       }
//                                     } else {
//                                       cartController.addToCart(
//                                         productId: id.toString(),
//                                       );
//                                     }

//                                     final varId = selectedVariation.value?.id;

//                                     if (varId != null) {
//                                       final selectedAttrMaps =
//                                           selectedVariation.value?.attributes
//                                               ?.map((attr) => {
//                                                     'attribute': attr.name,
//                                                     'value': attr.option,
//                                                   })
//                                               .toList();

//                                       cartController.addToCartWithVariation(
//                                         productId: id.toString(),
//                                         variation: selectedAttrMaps,
//                                       );
//                                     }
//                                   },
//                                   child: Get.find<CartController>().loader.value
//                                       ? const SizedBox(
//                                           height: 10,
//                                           width: 10,
//                                           child: CircularProgressIndicator(
//                                             strokeWidth: 0.5,
//                                             color: Colors.black,
//                                           ),
//                                         )
//                                       : Ink(
//                                           decoration: BoxDecoration(
//                                             gradient:
//                                                 AppColor.backgroundGradient,
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                           ),
//                                           child: Container(
//                                             alignment: Alignment.center,
//                                             constraints: BoxConstraints(
//                                               minHeight: 55,
//                                               maxWidth: double.infinity,
//                                             ),
//                                             child: Text(
//                                               cartController.isvarloading.value ? "Loading..." : "Add to Cart",
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                   style: ElevatedButton.styleFrom(
//                                     minimumSize: Size(double.infinity, 50),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                     padding: EdgeInsets.zero,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           GestureDetector(
//                             onTap: () {
//                               Get.back();
//                               bcontroller.tabIndex(2);
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 14),
//                               decoration: BoxDecoration(
//                                 gradient: AppColor.backgroundGradient,
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.shopping_cart_outlined,
//                                     color: AppColor.white,
//                                     size: 20,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
