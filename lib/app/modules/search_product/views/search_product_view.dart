import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';
import 'package:get/get.dart';
import 'package:buyzaars/app/modules/home/controllers/home_controller.dart';
import 'package:buyzaars/widgets/productDetailModal.dart';
// Update imports from letter_of_love to buyzaars
import 'package:buyzaars/utilities/colors.dart';

class SearchProductView extends StatefulWidget {
  const SearchProductView({super.key});

  @override
  _SearchProductViewstate createState() => _SearchProductViewstate();
}

class _SearchProductViewstate extends State<SearchProductView> {
  final HomeController controller =
      Get.find(); // Get the controller to fetch products
  TextEditingController searchController =
      TextEditingController(); // Controller for the search input
  List<WooProduct> filteredProducts = []; // List for storing filtered products

  @override
  void initState() {
    super.initState();
    // Initially, populate filteredProducts with all products from the controller
    filteredProducts = controller.allproducts;

    // Add a listener to the search field to filter products on input change
    searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    searchController.removeListener(
        _filterProducts); // Remove listener when the widget is disposed
    searchController.dispose();
    super.dispose();
  }

  // Function to filter the products list based on the search query
  void _filterProducts() {
    String query = searchController.text.toLowerCase();

    if (query.isEmpty) {
      setState(() {
        filteredProducts = controller.allproducts;
      });
    } else {
      setState(() {
        filteredProducts = controller.allproducts.where((product) {
          return product.name!.toLowerCase().contains(query);
        }).toList();
      });
    }
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
            decoration: BoxDecoration(
              color: AppColor.white,
            ),
            padding: EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FocusScope(
                      node: FocusScopeNode(),
                      child: TextFormField(
                        controller:
                            searchController, // Use the search controller
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
                          suffixIcon: searchController.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () => searchController.clear(),
                                  child: Icon(
                                    Icons.clear,
                                  ),
                                )
                              : SizedBox.shrink(),
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        style: TextStyle(
                          color: AppColor.red,
                        ),
                      ),
                    ),

                    // Use the filteredProducts list for displaying products
                    GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.7,
                        ),
                        padding: EdgeInsets.only(top: 20),
                        shrinkWrap: true,
                        itemCount: filteredProducts.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
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
                                  productDescription:
                                      product.description.toString(),
                                  price: "\$${product.price}",
                                  id: product.id,
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: AppColor.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
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
                        }),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
