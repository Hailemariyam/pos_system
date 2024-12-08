import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_sales_app/models/cart_item_model.dart';
// import 'cart_item_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final CartItem cartItem;

  const AddToCartEvent({required this.cartItem});

  @override
  List<Object> get props => [cartItem];
}

class RemoveFromCartEvent extends CartEvent {
  final String cartItemId;

  const RemoveFromCartEvent({required this.cartItemId});

  @override
  List<Object> get props => [cartItemId];
}

class ClearCartEvent extends CartEvent {}
