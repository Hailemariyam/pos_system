import 'package:equatable/equatable.dart';
import 'package:pos_sales_app/models/cart_item_model.dart';


abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitialState extends CartState {}

class CartUpdatedState extends CartState {
  final List<CartItem> cartItems;

  const CartUpdatedState({required this.cartItems});

  @override
  List<Object> get props => [cartItems];
}
