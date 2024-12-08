import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pos_sales_app/models/cart_item_model.dart';
import 'package:pos_sales_app/models/product_model.dart';
import 'package:uuid/uuid.dart';

class CartCubit extends HydratedCubit<List<CartItem>> {
  CartCubit() : super([]);

  final _uuid = Uuid();

  void addProduct(Product product) {
    final index = state.indexWhere((item) => item.product.productId == product.productId);
    if (index != -1) {
      // Update quantity if product is already in the cart
      final updatedItem = state[index].copyWith(
        quantity: state[index].quantity + 1,
      );
      final updatedCart = List<CartItem>.from(state)..[index] = updatedItem;
      emit(updatedCart);
    } else {
      // Add new item
      final newItem = CartItem(
        cartItemId: _uuid.v4(),
        product: product,
        quantity: 1,
      );
      emit(List<CartItem>.from(state)..add(newItem));
    }
  }

  void removeProduct(Product product) {
    final index = state.indexWhere((item) => item.product.productId == product.productId);
    if (index != -1) {
      final updatedCart = List<CartItem>.from(state)..removeAt(index);
      emit(updatedCart);
    }
  }

  void clearCart() {
    emit([]);
  }


  void updateQuantity(String cartItemId, int newQuantity) {
    final index = state.indexWhere((item) => item.cartItemId == cartItemId);
    if (index != -1) {
      if (newQuantity > 0) {
        final updatedItem = state[index].copyWith(quantity: newQuantity);
        final updatedCart = List<CartItem>.from(state)..[index] = updatedItem;
        emit(updatedCart);
      } else {
        removeCartItem(cartItemId);
      }
    }
  }

  void removeCartItem(String cartItemId) {
    final updatedCart =
        state.where((item) => item.cartItemId != cartItemId).toList();
    emit(updatedCart);
  }

  double get totalPrice => state.fold(0, (sum, item) => sum + item.totalPrice);

  @override
  List<CartItem>? fromJson(Map<String, dynamic> json) {
    final List<dynamic> items = json['cart'] ?? [];
    return items
        .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Map<String, dynamic>? toJson(List<CartItem> state) {
    return {
      'cart': state.map((item) => item.toJson()).toList(),
    };
  }
}
