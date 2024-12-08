import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import 'package:pos_sales_app/models/product_model.dart';

class ProductService {
  static Future<void> loadProducts() async {
    final productBox = await Hive.openBox<Product>('productBox');

    // Assuming JSON data is in the assets folder
    final String response = await rootBundle.loadString('assets/products.json');

    // Decode response as a map first
    final Map<String, dynamic> decodedJson = json.decode(response);

    // Extract the 'products' list from the decoded JSON map
    final List<dynamic> data = decodedJson['products'];

    // Iterate through the list and save each product into Hive
    for (var productJson in data) {
      final product = Product.fromJson(productJson);
      await productBox.add(product); // Save to Hive
    }
  }
}
