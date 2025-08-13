import 'dart:async';
import 'dart:convert';
import 'package:buyzaars/api_key.dart';
import 'package:buyzaars/models/product.dart';
import 'package:flutter_wp_woocommerce/models/product_variation.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;


class CproductdetailsController extends GetxController {
   var currentBanner = 0.obs;
  Product? product;
  String? imageUrl;
  String? productName;
  String? productDescription;
  String? price;
  List<int>? variation;
  List<WooProductItemAttribute>? attribute;

  final selectedAttributes = <String, RxString>{};
  Rx<WooProductVariation?> selectedVariation = Rx<WooProductVariation?>(null);
  List<WooProductVariation> allVariations = [];

  RxString currentPrice = ''.obs;
  var isvarloading = false.obs;

  Timer? _debounce;
@override
void onInit() {
  super.onInit();
  product = Get.arguments;
  imageUrl = product!.images.isNotEmpty ? product!.images[0].src : 'https://xombiemoonrecords.com/wp-content/uploads/2025/05/image-9-1.png';
  productName = product!.name;
  productDescription = product!.description;
  price = product!.price;
  variation = product!.variations;
  attribute = product!.attributes;

  for (var attr in attribute ?? []) {
    selectedAttributes[attr.name!] = ''.obs;
  }
  
  // Auto-select single-option attributes
  _autoSelectSingleOptionAttributes();
  
  if(product!.variations!.isNotEmpty){
    _fetchAllVariations();
  }
}


// Add this method to filter attributes with multiple options
List<WooProductItemAttribute> get filteredAttributes {
  return attribute?.where((attr) => 
    attr.options != null && attr.options!.length > 1
  ).toList() ?? [];
}

// Also add this method to auto-select single-option attributes
void _autoSelectSingleOptionAttributes() {
  for (var attr in attribute ?? []) {
    if (attr.options != null && attr.options!.length == 1) {
      selectedAttributes[attr.name!]?.value = attr.options!.first;
    }
  }
}


Future<void> _fetchAllVariations() async {
  isvarloading.value = true;
  int page = 1;
  bool hasMore = true;

  try {
    while (hasMore) {
      final response = await http.get(Uri.parse(
        '${woocommerce.baseUrl}/wp-json/wc/v3/products/${product!.id}/variations?per_page=100&page=$page&consumer_key=${woocommerce.consumerKey}&consumer_secret=${woocommerce.consumerSecret}'
      ));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final fetchedVariations = data.map((v) => WooProductVariation.fromJson(v)).toList();

        allVariations.addAll(fetchedVariations);

        print("Loaded page $page with ${fetchedVariations.length} variations");

        // Stop when less than 100 variations are returned (end of pages)
        if (fetchedVariations.length < 100) {
          hasMore = false;
        } else {
          page++;
        }
      } else {
        print("Failed to fetch variations for page $page: ${response.statusCode}");
        hasMore = false;
      }
    }
  } catch (e) {
    print("Error loading variations: $e");
  } finally {
    isvarloading.value = false;
    print("Total variations loaded: ${allVariations.length}");
  }
}

  /// Public method to call when user selects any attribute
  void onAttributeSelected(String name, String value) {
    if (selectedAttributes[name]?.value == value) return;

    selectedAttributes[name]?.value = value;

    // Debounce variation update
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _updateSelectedVariation();
    });
  }

  /// Main variation matcher logic with checks
  void _updateSelectedVariation() {
  if (!(attribute?.every((attr) => selectedAttributes[attr.name]?.value.isNotEmpty ?? false) ?? false)) {
    selectedVariation.value = null;
    return;
  }

  final selectedAttrMap = <String, String>{};
  selectedAttributes.forEach((key, value) {
    selectedAttrMap[key.toLowerCase()] = value.value.toLowerCase();
  });

  for (var variation in allVariations) {
    final matches = variation.attributes.every((attr) {
      final key = attr.name?.toLowerCase();
      return selectedAttrMap[key] == attr.option?.toLowerCase();
    });

    if (matches) {
      selectedVariation.value = variation;
      currentPrice.value = variation.price ?? product!.price!;
      return;
    }
  }

  selectedVariation.value = null; // no match
}


  /// Parses HTML content and returns plain text
  String parseHtmlToPlainText(String htmlContent) {
    final document = html_parser.parse(htmlContent);
    return document.body?.text.trim() ?? '';
  }
}
