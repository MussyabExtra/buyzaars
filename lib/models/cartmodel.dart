import 'package:flutter_wp_woocommerce/models/cart.dart';

class WooCart {
  String? currency;
  int? itemCount;
  List<WooCartItems>? items;
  bool? needsShipping;
  double? totalPrice;
  int? totalWeight;

  WooCart({
    this.currency,
    this.itemCount,
    this.items,
    this.needsShipping,
    this.totalPrice,
    this.totalWeight,
  });

  WooCart.fromJson(Map<String, dynamic> json) {
    currency = json['totals']['currency_code'];
    itemCount = json['items']?.length ?? 0;
    if (json['items'] != null) {
      items = <WooCartItems>[];
      json['items'].forEach((v) {
        items!.add(WooCartItems.fromJson(v));
      });
    }
    needsShipping = json['needs_shipping'];
    totalPrice = double.tryParse(json['totals']['line_total'] ?? '0');
    totalWeight = json['total_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currency'] = currency;
    data['item_count'] = itemCount;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['needs_shipping'] = needsShipping;
    data['total_price'] = totalPrice.toString();
    data['total_weight'] = totalWeight;
    return data;
  }
}

class WooCartVariation {
  String? attribute;
  String? value;

  WooCartVariation({this.attribute, this.value});

  WooCartVariation.fromJson(Map<String, dynamic> json) {
    attribute = json['attribute'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['attribute'] = attribute;
    data['value'] = value;
    return data;
  }
}

class WooCartItems {
  String? key;
  int? id;
  int? quantity;
  String? name;
  String? sku;
  String? permalink;
  List<WooCartImages>? images;
  double? price;
  double? linePrice;
  List<WooCartVariation>? variation;

  WooCartItems({
    this.key,
    this.id,
    this.quantity,
    this.name,
    this.sku,
    this.permalink,
    this.images,
    this.price,
    this.linePrice,
    this.variation,
  });

  WooCartItems.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'];
    quantity = json['quantity'];
    name = json['name'];
    sku = json['sku'];
    permalink = json['permalink'];
    if (json['images'] != null) {
      images = <WooCartImages>[];
      json['images'].forEach((v) {
        images!.add(WooCartImages.fromJson(v));
      });
    }
    price = double.tryParse(json['prices']['price'] ?? '0');
    linePrice = double.tryParse(json['totals']['line_total'] ?? '0');
    if (json['variation'] != null) {
      variation = <WooCartVariation>[];
      json['variation'].forEach((v) {
        variation!.add(WooCartVariation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['key'] = key;
    data['id'] = id;
    data['quantity'] = quantity;
    data['name'] = name;
    data['sku'] = sku;
    data['permalink'] = permalink;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['price'] = price.toString();
    data['line_price'] = linePrice.toString();
    if (variation != null) {
      data['variation'] = variation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
