import 'package:hive/hive.dart';
import 'product_model.dart';

part 'cart_item_model.g.dart'; // This will be the generated file for Hive Adapter

@HiveType(typeId: 1)
class CartItem {
  @HiveField(0)
  final String cartItemId; // Unique ID for the cart item

  @HiveField(1)
  final Product product; // The product added to the cart

  @HiveField(2)
  final int quantity; // Quantity of the product in the cart

  // Constructor
  CartItem({
    required this.cartItemId,
    required this.product,
    required this.quantity,
  });

  // Calculate total price dynamically
  double get totalPrice => product.price * quantity;

  // Copy method for updating cart item
  CartItem copyWith({
    String? cartItemId,
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      cartItemId: cartItemId ?? this.cartItemId,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  // Convert CartItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'cartItemId': cartItemId,
      'product': product.toJson(), // Assuming Product has a toJson method
      'quantity': quantity,
    };
  }

  // Create CartItem from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartItemId: json['cartItemId'] as String,
      product: Product.fromJson(json['product']
          as Map<String, dynamic>), // Assuming Product has a fromJson method
      quantity: json['quantity'] as int,
    );
  }

  @override
  String toString() {
    return 'CartItem(cartItemId: $cartItemId, product: ${product.name}, quantity: $quantity, totalPrice: $totalPrice)';
  }
}
