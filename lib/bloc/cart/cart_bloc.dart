import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sales_app/models/cart_item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItem> _cartItems = [];

  CartBloc() : super(CartInitialState()) {
    on<AddToCartEvent>((event, emit) {
      // Check if the item already exists in the cart
      final index = _cartItems.indexWhere(
        (item) => item.product == event.cartItem.product,
      );

      if (index == -1) {
        // Add new item to the cart
        _cartItems.add(event.cartItem);
      } else {
        // Update existing item by creating a new CartItem instance
        final updatedItem = CartItem(
          cartItemId: _cartItems[index].cartItemId,
          product: _cartItems[index].product,
          quantity: _cartItems[index].quantity + event.cartItem.quantity,
        );

        _cartItems[index] = updatedItem;
      }

      emit(CartUpdatedState(cartItems: List.from(_cartItems)));
    });

    on<RemoveFromCartEvent>((event, emit) {
      _cartItems.removeWhere((item) => item.cartItemId == event.cartItemId);
      emit(CartUpdatedState(cartItems: List.from(_cartItems)));
    });

    on<ClearCartEvent>((event, emit) {
      _cartItems.clear();
      emit(CartUpdatedState(cartItems: List.from(_cartItems)));
    });
  }
}
