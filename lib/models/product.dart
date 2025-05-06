class Product {
  final int id;
  final String name;
  final String slug;
  final String permalink;
  final String dateCreated;
  final String dateCreatedGMT;
  final String dateModified;
  final String dateModifiedGMT;
  final String type;
  final String status;
  final bool featured;
  final String catalogVisibility;
  final String description;
  final String shortDescription;
  final String sku;
  final String price;
  final String regularPrice;
  final String salePrice;
  final bool onSale;
  final bool purchasable;
  final int totalSales;
  final bool virtual;
  final bool downloadable;
  final List<ImageData> images;
  final List<Category> categories;
  final String priceHtml;
  final List<Attribute> attributes; // New attribute section
  final List<int> variations; // Variation IDs

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.dateCreated,
    required this.dateCreatedGMT,
    required this.dateModified,
    required this.dateModifiedGMT,
    required this.type,
    required this.status,
    required this.featured,
    required this.catalogVisibility,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.onSale,
    required this.purchasable,
    required this.totalSales,
    required this.virtual,
    required this.downloadable,
    required this.images,
    required this.categories,
    required this.priceHtml,
    required this.attributes,
    required this.variations,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      permalink: json['permalink'],
      dateCreated: json['date_created'],
      dateCreatedGMT: json['date_created_gmt'],
      dateModified: json['date_modified'],
      dateModifiedGMT: json['date_modified_gmt'],
      type: json['type'],
      status: json['status'],
      featured: json['featured'],
      catalogVisibility: json['catalog_visibility'],
      description: json['description'],
      shortDescription: json['short_description'],
      sku: json['sku'],
      price: json['price'],
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'] ?? '',
      onSale: json['on_sale'],
      purchasable: json['purchasable'],
      totalSales: json['total_sales'],
      virtual: json['virtual'],
      downloadable: json['downloadable'],
      images: (json['images'] as List)
          .map((imageJson) => ImageData.fromJson(imageJson))
          .toList(),
      categories: (json['categories'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList(),
      priceHtml: json['price_html'],
      attributes: (json['attributes'] as List)
          .map((attrJson) => Attribute.fromJson(attrJson))
          .toList(),
      variations: List<int>.from(json['variations']),
    );
  }
}

class ImageData {
  final int id;
  final String src;
  final String name;
  final String alt;

  ImageData({
    required this.id,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      src: json['src'],
      name: json['name'],
      alt: json['alt'] ?? '',
    );
  }
}

class Category {
  final int id;
  final String name;
  final String slug;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class Attribute {
  final int id;
  final String name;
  final String slug;
  final bool visible;
  final bool variation;
  final List<String> options;

  Attribute({
    required this.id,
    required this.name,
    required this.slug,
    required this.visible,
    required this.variation,
    required this.options,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      visible: json['visible'],
      variation: json['variation'],
      options: List<String>.from(json['options']),
    );
  }
}
