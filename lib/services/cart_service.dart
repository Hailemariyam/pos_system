import 'package:pos_sales_app/bloc/cart/cart_state.dart';
import 'package:pos_sales_app/models/cart_item_model.dart';
import 'package:pos_sales_app/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sales_app/bloc/cart/cart_bloc.dart';
import 'package:pos_sales_app/bloc/cart/cart_event.dart';

class CartService {
  final CartBloc cartBloc;

  CartService({required this.cartBloc});

  /// Add an item to the cart
  void addToCart(Product product, int quantity) {
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be greater than 0');
    }

    final cartItem = CartItem(
      cartItemId: DateTime.now().toString(),
      product: product,
      quantity: quantity,
    );

    cartBloc.add(AddToCartEvent(cartItem: cartItem));
  }

  /// Remove an item from the cart by its ID
  void removeFromCart(String cartItemId) {
    cartBloc.add(RemoveFromCartEvent(cartItemId: cartItemId));
  }

  /// Clear all items in the cart
  void clearCart() {
    cartBloc.add(ClearCartEvent());
  }

  /// Get the current cart items from the state
  List<CartItem> getCartItems() {
    final currentState = cartBloc.state;
    if (currentState is CartUpdatedState) {
      return currentState.cartItems;
    }
    return [];
  }

  /// Get the total price of all items in the cart
  double getTotalPrice() {
    final cartItems = getCartItems();
    return cartItems.fold(0.0, (total, item) => total + item.totalPrice);
  }

  /// Check if a specific product is already in the cart
  bool isProductInCart(Product product) {
    final cartItems = getCartItems();
    return cartItems.any((item) => item.product == product);
  }
}
