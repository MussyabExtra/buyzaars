class ProductCategory {
  final int id;
  final String name;
  final String slug;
  final int parent;
  final String description;
  final String display;
  final ImageData? image;
  final int menuOrder;
  final int count;

  ProductCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.parent,
    required this.description,
    required this.display,
    this.image,
    required this.menuOrder,
    required this.count,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      parent: json['parent'],
      description: json['description'],
      display: json['display'],
      image: json['image'] != null ? ImageData.fromJson(json['image']) : null,
      menuOrder: json['menu_order'],
      count: json['count'],
    );
  }
}

class ImageData {
  final int id;
  final String dateCreated;
  final String dateCreatedGmt;
  final String dateModified;
  final String dateModifiedGmt;
  final String src;
  final String title;
  final String alt;

  ImageData({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.src,
    required this.title,
    required this.alt,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      dateCreated: json['date_created'],
      dateCreatedGmt: json['date_created_gmt'],
      dateModified: json['date_modified'],
      dateModifiedGmt: json['date_modified_gmt'],
      src: json['src'],
      title: json['title'],
      alt: json['alt'],
    );
  }
}