import 'package:buyzaars/app/modules/cart/controllers/cart_controller.dart';
import 'package:buyzaars/app/modules/productdetails/controllers/productdetails_controller.dart';
import 'package:buyzaars/utilities/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class ProductdetailsView extends GetView<ProductdetailsController> {
  const ProductdetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final double imageHeight = 360.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image Carousel with Rounded Bottom
            Stack(
              children: [
                Builder(
                  builder: (context) {
                    final images = controller.product?.images ?? [];
                    if (images.isEmpty) {
                      // Show a placeholder if there are no images
                      return Container(
                        height: imageHeight,
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: Icon(Icons.image_not_supported,
                            size: 80, color: Colors.grey.shade500),
                      );
                    }
                    return cs.CarouselSlider.builder(
                      options: cs.CarouselOptions(
                        autoPlay: false,
                        viewportFraction: 1.0,
                        height: imageHeight,
                        onPageChanged: (index, reason) =>
                            controller.currentBanner.value = index,
                      ),
                      itemCount: images.length,
                      itemBuilder: (context, index, realIndex) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          imageUrl: images[index].src ?? '',
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Icon(
                              Icons.broken_image,
                              size: 80,
                              color: Colors.grey.shade500),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 36,
                  right: 16,
                  child: Builder(
                    builder: (context) {
                      final images = controller.product?.images ?? [];
                      if (images.isEmpty) return const SizedBox.shrink();
                      return Obx(() => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: AppColor.secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: images.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => controller.currentBanner.value =
                                      entry.key,
                                  child: Container(
                                    width: 6.0,
                                    height: 6.0,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6.0,
                                      horizontal: 3.0,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: controller.currentBanner.value ==
                                              entry.key
                                          ? AppColor.red
                                          : Colors.grey,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ));
                    },
                  ),
                ),
              ],
            ),

            // Product Details (Stacked over seamlessly)
            Container(
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(3, 0),
                  ),
                ],
              ),

              transform: Matrix4.translationValues(
                0,
                -24,
                0,
              ), // Pull up into curve
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tags
                  Row(
                    children: [
                      Chip(
                        label: const Text('Top Rated'),
                        backgroundColor: AppColor.red,
                        labelStyle: const TextStyle(color: Colors.white),
                        side: BorderSide.none,
                      ),
                      // const SizedBox(width: 8),
                      // Chip(
                      //   label: const Text('Free Shipping'),
                      //   backgroundColor: AppColor.grey,
                      //   labelStyle: const TextStyle(color: Colors.white),
                      //   side: BorderSide.none,
                      // ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Title & Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.product?.name ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Obx(() {
                        return controller.isvarloading.value
                            ? Container(
                                margin: EdgeInsets.all(10),
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  strokeWidth: 0.5,
                                  color: Colors.black,
                                ),
                              )
                            : Text(
                                controller.currentPrice.value.isNotEmpty
                                    ? '\$${controller.currentPrice.value}'
                                    : '\$${controller.product?.price ?? ''}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black,
                                  fontSize: 25,
                                ),
                              );
                      }),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Rating

                  const SizedBox(height: 10),

                  // Description
                  ReadMoreText(
                    controller.product?.description?.isNotEmpty == true
                        ? controller.parseHtmlToPlainText(
                            controller.product!.description!,
                          )
                        : 'No description available',
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' See more',
                    trimExpandedText: ' Show less',
                    colorClickableText: Colors.black,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 14,
                    ),
                    moreStyle: const TextStyle(color: Colors.black),
                    lessStyle: const TextStyle(color: Colors.black),
                  ),

                  const SizedBox(height: 20),

                  // Replace the existing attribute selection section with this:
                  if (controller.filteredAttributes.isNotEmpty &&
                      controller.variation != [] &&
                      controller.variation != null &&
                      controller.variation!.isNotEmpty) ...[
                    Text(
                      'Available Options',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    ...controller.filteredAttributes
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
                                              (option) => Obx(() =>
                                                  GestureDetector(
                                                    onTap: controller
                                                            .isvarloading.value
                                                        ? null
                                                        : () {
                                                            controller
                                                                .onAttributeSelected(
                                                                    attr.name!,
                                                                    option);
                                                          },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: controller
                                                                    .selectedAttributes[
                                                                        attr.name!]
                                                                    ?.value ==
                                                                option
                                                            ? AppColor.red
                                                            : Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Text(
                                                        option,
                                                        style: TextStyle(
                                                          color: controller
                                                                      .selectedAttributes[
                                                                          attr.name!]
                                                                      ?.value ==
                                                                  option
                                                              ? Colors.white
                                                              : Colors.black,
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
                              // Update the add-to-cart button onPressed logic:
                              onPressed: Get.find<CartController>().loader.value
                                  ? null
                                  : () {
                                      if (controller
                                              .filteredAttributes.isNotEmpty &&
                                          controller.variation != [] &&
                                          controller.variation != null &&
                                          controller.variation!.isNotEmpty) {
                                        bool allSelected =
                                            controller.filteredAttributes.every(
                                          (attr) =>
                                              controller
                                                  .selectedAttributes[
                                                      attr.name!]
                                                  ?.value
                                                  .isNotEmpty ??
                                              false,
                                        );

                                        if (!allSelected ||
                                            controller
                                                    .selectedVariation.value ==
                                                null) {
                                          Get.snackbar('Error',
                                              'Please select a valid variation',
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white);
                                          return;
                                        }
                                      } else {
                                        Get.find<CartController>().addToCart(
                                          productId:
                                              controller.product!.id.toString(),
                                        );
                                      }

                                      final varId = controller
                                          .selectedVariation.value?.id;

                                      if (varId != null) {
                                        final selectedAttrMaps = controller
                                            .selectedVariation.value?.attributes
                                            .map((attr) => {
                                                  'attribute': attr.name,
                                                  'value': attr.option,
                                                })
                                            .toList();

                                        Get.find<CartController>()
                                            .addToCartWithVariation(
                                          productId:
                                              controller.product!.id.toString(),
                                          variation: selectedAttrMaps,
                                        );
                                      }
                                    },

                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                backgroundColor: AppColor.red,
                                disabledBackgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: Get.find<CartController>().loader.value
                                  ? const SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 0.5,
                                        color: AppColor.white,
                                      ),
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      constraints: BoxConstraints(
                                        minHeight: 55,
                                        maxWidth: double.infinity,
                                      ),
                                      child: Text(
                                        controller.isvarloading.value
                                            ? "Loading..."
                                            : "Add to Cart",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
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
    );
  }
}
