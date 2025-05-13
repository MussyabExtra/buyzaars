import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';
import 'package:get/get.dart';
import 'package:buyzaars/app/modules/home/controllers/home_controller.dart';
import 'package:buyzaars/widgets/productDetailModal.dart';
import 'package:buyzaars/utilities/colors.dart';

class SearchProductView extends StatefulWidget {
  const SearchProductView({super.key});

  @override
  _SearchProductViewstate createState() => _SearchProductViewstate();
}

class _SearchProductViewstate extends State<SearchProductView> {
  final HomeController controller = Get.find();
  TextEditingController searchController = TextEditingController();
  List<WooProduct> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = controller.allproducts;
    searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterProducts);
    searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = query.isEmpty
          ? controller.allproducts
          : controller.allproducts
              .where((product) => product.name!.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'All Products',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          centerTitle: false,
          backgroundColor: AppColor.red,
          foregroundColor: AppColor.white,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.white,
            ),
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Products',
                      prefixIcon: Icon(Icons.search, color: AppColor.red),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    style: TextStyle(
                      color: AppColor.red,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return Container(
                          padding: EdgeInsets.all(10),
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
                              productDetailsModal(
                                context: context,
                                imageUrl: product.images[0].src.toString(),
                                productName: product.name.toString(),
                                productDescription:
                                    product.description.toString(),
                                price: "\$${product.price}",
                                id: product.id,
                                variation: product.variations,
                                attribute: product.attributes,
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: AppColor.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        product.images[0].src.toString(),
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  product.name ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
