import 'package:buyzaars/utilities/colors.dart';
import 'package:buyzaars/app/modules/cart/controllers/cart_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends GetView<CartController> {
  CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          title: Text(
            'Cart',
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.fetchCartItems();
                    },
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColor.red,
                          ),
                        );
                      }
                    
                      if (controller.cartItems.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 64,
                                color: AppColor.primarycolor.withOpacity(0.5),
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Your cart is empty",
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    
                      return ListView.builder(
                        itemCount: controller.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = controller.cartItems[index];
                          return Dismissible(
                            key: Key(item.key.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              color: Colors.red,
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              controller.removeFromCart(item.key.toString());
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      child: CachedNetworkImage(
                                        imageUrl: item.images!.first.src ??
                                            'https://via.placeholder.com/80x120',
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(
                                            color: Colors.grey[300],
                                            child:
                                                Icon(Icons.image_not_supported),
                                          ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              color: Colors.grey[300],
                                              child: Icon(Icons.error),
                                            ),
                                        
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name ?? '',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColor.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 8),
                                        //variation
                                        if (item.variation != null && item.variation!.isNotEmpty)
                                          Text(
                                            item.variation!
                                                .map((e) => '${e.attribute}: ${e.value}')
                                                .join(', '),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppColor.black,
                                            ),
                                          ),
                                        Text(
                                          '\$${(double.parse(item.price.toString()) / 100).toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColor.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  // Increment and Decrement buttons
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (item.quantity! > 1) {
                                            controller.updateCartItemQuantity(
                                                item.key.toString(),
                                                item.quantity! - 1,
                                                item.id!);
                                          }
                                        },
                                        icon: Icon(Icons.remove),
                                      ),
                                      Text(
                                        item.quantity.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.black,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.updateCartItemQuantity(
                                              item.key.toString(),
                                              item.quantity! + 1,
                                              item.id!);
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
                Obx(() {
                  if (controller.cartItems.isNotEmpty) {
                    return Column(
                      children: [
                        Divider(thickness: 1),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${(controller.totalPrice / 100).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => Get.toNamed('/checkout'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Proceed to Checkout',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
