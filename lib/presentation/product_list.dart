import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_sales_app/bloc/cartcubit.dart';
import 'package:pos_sales_app/models/cart_item_model.dart';
import 'package:pos_sales_app/models/product_model.dart';
import 'package:pos_sales_app/presentation/product_detail.dart';
import 'package:pos_sales_app/presentation/screens/cart_screen.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS System'),
        actions: [
          BlocBuilder<CartCubit, List<CartItem>>(
            builder: (context, cartItems) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CartScreen()),
                      );
                    },
                  ),
                  if (cartItems.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '${cartItems.length}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<Product>>(
        valueListenable: Hive.box<Product>('productBox').listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return Center(child: Text('No products available'));
          }
          final products = box.values.toList();

          return LayoutBuilder(
            builder: (context, constraints) {
              // Determine the number of columns based on screen width
              int crossAxisCount = 2; // Default for mobile
              double childAspectRatio = 0.58; // Default aspect ratio for mobile

              if (constraints.maxWidth > 1200) {
                // Desktop size (large screens)
                crossAxisCount = 4; // More columns for large screens
                childAspectRatio = 0.6; // Adjust aspect ratio for desktop
              } else if (constraints.maxWidth > 600) {
                // Tablet size (medium screens)
                crossAxisCount = 3; // Columns for tablets
                childAspectRatio = 0.7; // Adjust aspect ratio for tablets
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount, // Dynamic number of columns
                  crossAxisSpacing: 10, // Horizontal spacing between items
                  mainAxisSpacing: 10, // Vertical spacing between items
                  childAspectRatio: childAspectRatio, // Dynamic aspect ratio
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return GestureDetector(
                    onTap: () {
                      // Navigate to the product detail screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display the product image
                          Image.asset(
                            product.imageUrl,
                            fit: BoxFit.cover,
                            height: 120, // Adjust height as needed
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\$${product.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          // Use Spacer or Expanded to prevent overflow
                          Spacer(),
                          // Add to Cart button
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.add_shopping_cart),
                              onPressed: () {
                                context.read<CartCubit>().addProduct(product);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
