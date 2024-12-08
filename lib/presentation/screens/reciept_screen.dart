import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sales_app/bloc/cartcubit.dart';
import 'package:pos_sales_app/models/cart_item_model.dart';

class CashierScreen extends StatefulWidget {
  @override
  _CashierScreenState createState() => _CashierScreenState();
}

class _CashierScreenState extends State<CashierScreen> {
  String _selectedPaymentMethod = 'Cash'; // Default payment method
  bool _isPaid = false; // To track if payment is done

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cashier - Process Payment'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return const Center(
              child: Text('No items in the cart!'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Image.network(
                          cartItem.product.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(cartItem.product.name),
                        subtitle: Text(
                          '${cartItem.quantity} x \$${cartItem.product.price.toStringAsFixed(2)}',
                        ),
                        trailing: Text(
                          '\$${(cartItem.quantity * cartItem.product.price).toStringAsFixed(2)}',
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${context.read<CartCubit>().totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: _selectedPaymentMethod,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPaymentMethod = newValue!;
                    });
                  },
                  items: <String>['Cash', 'ATM POS Machine']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: _isPaid
                      ? null
                      : () {
                          setState(() {
                            _isPaid = true; // Mark the payment as completed
                          });

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Payment Confirmed'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Payment Method:'),
                                  Text(_selectedPaymentMethod),
                                  const SizedBox(height: 10),
                                  const Text('Receipt:'),
                                  const SizedBox(height: 10),
                                  // Order summary and receipt display
                                  for (var item in cartItems)
                                    Text(
                                      '${item.product.name} x${item.quantity} - \$${(item.quantity * item.product.price).toStringAsFixed(2)}',
                                    ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Total: \$${context.read<CartCubit>().totalPrice.toStringAsFixed(2)}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Clear the cart after transaction
                                    context.read<CartCubit>().clearCart();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                  child: _isPaid
                      ? const Text('Payment Complete')
                      : const Text('Confirm Payment'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
