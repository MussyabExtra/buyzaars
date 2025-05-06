import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buyzaars/app/modules/home/controllers/home_controller.dart';
import 'package:buyzaars/models/product.dart';
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
  List<Product> filteredProducts = []; // List for storing filtered products

  @override
  void initState() {
    super.initState();
    // Initially, populate filteredProducts with all products from the controller
    filteredProducts = controller.products;

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
        filteredProducts = controller.products;
      });
    } else {
      setState(() {
        filteredProducts = controller.products.where((product) {
          return product.name.toLowerCase().contains(query);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: AppColor.WhitebackgroundGradient,
            ),
            padding: EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                      child: Text(
                        'Products',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: AppColor.white,
                        ),
                      ),
                    ),
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
                          fillColor: Colors.white,
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

                    SizedBox(height: 15),
                    // Use the filteredProducts list for displaying products
                    ListView.builder(
                        padding: EdgeInsets.only(top: 20),
                        shrinkWrap: true,
                        itemCount: filteredProducts.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          String imageUrl = '';
                          if (product.images.isNotEmpty) {
                            imageUrl = product
                                .images.first.src; // Get the first image URL
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                productDetailsModal(
                                  context: context,
                                  imageUrl: imageUrl,
                                  productName: product.name,
                                  productDescription: product.description,
                                  authorName: "Marcia Weis",
                                  authorDescription: product.shortDescription,
                                  price: "\$${product.price}",
                                  id: product.id,
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            product.images.isNotEmpty
                                                ? product.images.first.src
                                                : ''),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.bold,
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
                        }),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
