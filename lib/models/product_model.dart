import 'package:hive/hive.dart';

part 'product_model.g.dart'; // This will be the generated file for Hive Adapter

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final String productId; // Unique ID for the product

  @HiveField(1)
  final String name; // Name of the product

  @HiveField(2)
  final String description; // Description of the product

  @HiveField(3)
  final String category; // Category the product belongs to

  @HiveField(4)
  final double price; // Price of the product

  @HiveField(5)
  final int quantityInStock; // Number of units available in stock

  @HiveField(6)
  final String sku; // SKU (Stock Keeping Unit) of the product

  @HiveField(7)
  final String barcode; // Barcode associated with the product

  @HiveField(8)
  final String imageUrl; // URL for the product image

  @HiveField(9)
  final double taxRate; // Tax rate applicable to the product

  // Constructor
  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.quantityInStock,
    required this.sku,
    required this.barcode,
    required this.imageUrl,
    required this.taxRate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
      quantityInStock: json['quantity_in_stock'],
      sku: json['sku'],
      barcode: json['barcode'],
      imageUrl: json['image_url'],
      taxRate: json['tax_rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'quantity_in_stock': quantityInStock,
      'sku': sku,
      'barcode': barcode,
      'image_url': imageUrl,
      'tax_rate': taxRate,
    };
  }
}
