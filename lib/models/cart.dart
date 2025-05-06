// Main Model to handle the cart response
class CartResponse {
  List<CartItem> items;
  List<dynamic> coupons;
  List<dynamic> fees;
  Totals totals;
  Address shippingAddress;
  Address billingAddress;
  bool needsPayment;
  bool needsShipping;
  List<String> paymentRequirements;
  bool hasCalculatedShipping;
  List<dynamic> shippingRates;
  int itemsCount;
  int itemsWeight;
  List<dynamic> crossSells;
  List<dynamic> errors;
  List<String> paymentMethods;
  Map<String, dynamic> extensions;

  CartResponse({
    required this.items,
    required this.coupons,
    required this.fees,
    required this.totals,
    required this.shippingAddress,
    required this.billingAddress,
    required this.needsPayment,
    required this.needsShipping,
    required this.paymentRequirements,
    required this.hasCalculatedShipping,
    required this.shippingRates,
    required this.itemsCount,
    required this.itemsWeight,
    required this.crossSells,
    required this.errors,
    required this.paymentMethods,
    required this.extensions,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      items: List<CartItem>.from(json['items'].map((x) => CartItem.fromJson(x))),
      coupons: List<dynamic>.from(json['coupons']),
      fees: List<dynamic>.from(json['fees']),
      totals: Totals.fromJson(json['totals']),
      shippingAddress: Address.fromJson(json['shipping_address']),
      billingAddress: Address.fromJson(json['billing_address']),
      needsPayment: json['needs_payment'],
      needsShipping: json['needs_shipping'],
      paymentRequirements: List<String>.from(json['payment_requirements']),
      hasCalculatedShipping: json['has_calculated_shipping'],
      shippingRates: List<dynamic>.from(json['shipping_rates']),
      itemsCount: json['items_count'],
      itemsWeight: json['items_weight'],
      crossSells: List<dynamic>.from(json['cross_sells']),
      errors: List<dynamic>.from(json['errors']),
      paymentMethods: List<String>.from(json['payment_methods']),
      extensions: json['extensions'] ?? {},
    );
  }
}

// Cart Item Model
class CartItem {
  int? id;
  String? name;
  String? description;
  String? shortDescription;
  String? price;
  String? regularPrice;
  String? salePrice;
  List<ImageData>? images;
  bool? backordersAllowed;
  bool? soldIndividually;
  String? catalogVisibility;
  String? permalink;

  CartItem({
    this.id,
    this.name,
    this.description,
    this.shortDescription,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.images,
    this.backordersAllowed,
    this.soldIndividually,
    this.catalogVisibility,
    this.permalink,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      shortDescription: json['short_description'],
      price: json['price'],
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'],
      images: json['images'] != null
          ? List<ImageData>.from(json['images'].map((x) => ImageData.fromJson(x)))
          : null,
      backordersAllowed: json['backorders_allowed'],
      soldIndividually: json['sold_individually'],
      catalogVisibility: json['catalog_visibility'],
      permalink: json['permalink'],
    );
  }
}

class ImageData {
  String? src;
  String? name;
  String? alt;

  ImageData({
    this.src,
    this.name,
    this.alt,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      src: json['src'],
      name: json['name'],
      alt: json['alt'],
    );
  }
}
// Quantity Limits Model
class QuantityLimits {
  int minimum;
  int maximum;
  int multipleOf;
  bool editable;

  QuantityLimits({
    required this.minimum,
    required this.maximum,
    required this.multipleOf,
    required this.editable,
  });

  factory QuantityLimits.fromJson(Map<String, dynamic> json) {
    return QuantityLimits(
      minimum: json['minimum'],
      maximum: json['maximum'],
      multipleOf: json['multiple_of'],
      editable: json['editable'],
    );
  }
}

// Variation Model
class Variation {
  String attribute;
  String value;

  Variation({
    required this.attribute,
    required this.value,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      attribute: json['attribute'],
      value: json['value'],
    );
  }
}

// Image Model
// class ImageData {
//   int id;
//   String src;
//   String thumbnail;
//   String srcset;
//   String sizes;
//   String name;
//   String alt;

//   ImageData({
//     required this.id,
//     required this.src,
//     required this.thumbnail,
//     required this.srcset,
//     required this.sizes,
//     required this.name,
//     required this.alt,
//   });

//   factory ImageData.fromJson(Map<String, dynamic> json) {
//     return ImageData(
//       id: json['id'],
//       src: json['src'],
//       thumbnail: json['thumbnail'],
//       srcset: json['srcset'],
//       sizes: json['sizes'],
//       name: json['name'],
//       alt: json['alt'],
//     );
//   }
// }

// Prices Model
class Prices {
  String price;
  String regularPrice;
  String salePrice;
  dynamic priceRange;
  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyDecimalSeparator;
  String currencyThousandSeparator;
  String currencyPrefix;
  String currencySuffix;
  RawPrices rawPrices;

  Prices({
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.priceRange,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyMinorUnit,
    required this.currencyDecimalSeparator,
    required this.currencyThousandSeparator,
    required this.currencyPrefix,
    required this.currencySuffix,
    required this.rawPrices,
  });

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
      price: json['price'],
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'],
      priceRange: json['price_range'],
      currencyCode: json['currency_code'],
      currencySymbol: json['currency_symbol'],
      currencyMinorUnit: json['currency_minor_unit'],
      currencyDecimalSeparator: json['currency_decimal_separator'],
      currencyThousandSeparator: json['currency_thousand_separator'],
      currencyPrefix: json['currency_prefix'],
      currencySuffix: json['currency_suffix'],
      rawPrices: RawPrices.fromJson(json['raw_prices']),
    );
  }
}

// Raw Prices Model
class RawPrices {
  int precision;
  String price;
  String regularPrice;
  String salePrice;

  RawPrices({
    required this.precision,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
  });

  factory RawPrices.fromJson(Map<String, dynamic> json) {
    return RawPrices(
      precision: json['precision'],
      price: json['price'],
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'],
    );
  }
}

// Totals Model
class Totals {
  String lineSubtotal;
  String lineSubtotalTax;
  String lineTotal;
  String lineTotalTax;
  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyDecimalSeparator;
  String currencyThousandSeparator;
  String currencyPrefix;
  String currencySuffix;

  Totals({
    required this.lineSubtotal,
    required this.lineSubtotalTax,
    required this.lineTotal,
    required this.lineTotalTax,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyMinorUnit,
    required this.currencyDecimalSeparator,
    required this.currencyThousandSeparator,
    required this.currencyPrefix,
    required this.currencySuffix,
  });

  factory Totals.fromJson(Map<String, dynamic> json) {
    return Totals(
      lineSubtotal: json['line_subtotal'],
      lineSubtotalTax: json['line_subtotal_tax'],
      lineTotal: json['line_total'],
      lineTotalTax: json['line_total_tax'],
      currencyCode: json['currency_code'],
      currencySymbol: json['currency_symbol'],
      currencyMinorUnit: json['currency_minor_unit'],
      currencyDecimalSeparator: json['currency_decimal_separator'],
      currencyThousandSeparator: json['currency_thousand_separator'],
      currencyPrefix: json['currency_prefix'],
      currencySuffix: json['currency_suffix'],
    );
  }
}

// Address Model
class Address {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String phone;
  String email;

  Address({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.phone,
    required this.email,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      company: json['company'] ?? '',
      address1: json['address_1'] ?? '',
      address2: json['address_2'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
