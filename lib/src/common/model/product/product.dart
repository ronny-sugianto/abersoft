import 'package:abersoft/src/common/common.dart';

class Product extends BaseModel {
  final int? id;
  final String? name;
  final String? imageUrl;
  final String? productDescription;
  final List<Product>? listBestProduct;
  final List<Product>? listAllProduct;

  Product({
    this.id,
    this.name,
    this.imageUrl,
    this.productDescription,
    this.listBestProduct,
    this.listAllProduct,
  });

  @override
  BaseModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
    String? productDescription,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        productDescription: productDescription ?? this.productDescription,
      );

  factory Product.fromJson(Map<String, dynamic> json) {
    List<Product> listBestProduct = [];
    List<Product> listAllProduct = [];

    if (json['bestProduct'] != null && json['bestProduct'] is List) {
      for (Map<String, dynamic> json in json['bestProduct']) {
        listBestProduct.add(Product.fromJson(json));
      }
    }

    if (json['allProduct'] != null && json['allProduct'] is List) {
      for (Map<String, dynamic> json in json['allProduct']) {
        listAllProduct.add(Product.fromJson(json));
      }
    }

    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      productDescription: json['productDescription'],
      listBestProduct: listBestProduct,
      listAllProduct: listAllProduct,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "productDescription": productDescription,
      };
}
