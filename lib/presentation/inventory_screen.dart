import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos_sales_app/models/product_model.dart';
import 'package:pos_sales_app/services/product_service.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: Colors.tealAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 800;
          bool isTablet =
              constraints.maxWidth > 600 && constraints.maxWidth <= 800;

          return FutureBuilder(
            future: ProductService.loadProducts(), // Ensure products are loaded
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return ValueListenableBuilder(
                valueListenable: Hive.box<Product>('productBox').listenable(),
                builder: (context, Box<Product> productBox, _) {
                  List<Product> products = productBox.values.toList();

                  if (products.isEmpty) {
                    return Center(child: Text('No products found.'));
                  }

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isDesktop) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Inventory List',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Implement add inventory item functionality
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text("Add Item"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    textStyle: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                          if (isTablet || !isDesktop) ...[
                            ElevatedButton.icon(
                              onPressed: () {
                                // Implement add inventory item functionality
                              },
                              icon: const Icon(Icons.add),
                              label: const Text("Add Item"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                              ),
                            ),
                            SizedBox(height: 16),
                          ],
                          // Inventory List
                          SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 8,
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    Product product = products[index];
                                    return SingleChildScrollView(
                                      child: Card(
                                        elevation: 4,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(16.0),
                                          leading: product.imageUrl != null
                                              ? Image.asset(
                                                  product.imageUrl!,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                )
                                              : Icon(
                                                  Icons.inventory,
                                                  color: Colors.teal,
                                                  size: 36,
                                                ),
                                          title: Text(
                                            product.name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            'Quantity: ${product.quantityInStock}',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          trailing: PopupMenuButton<String>(
                                            onSelected: (value) {
                                              // Handle edit or delete actions
                                              if (value == 'delete') {
                                                _deleteProduct(product);
                                              }
                                            },
                                            itemBuilder: (BuildContext context) {
                                              return [
                                                const PopupMenuItem<String>(
                                                  value: 'edit',
                                                  child: Text('Edit'),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: 'delete',
                                                  child: Text('Delete'),
                                                ),
                                              ];
                                            },
                                            icon: const Icon(Icons.more_vert),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
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

  // Helper function to delete a product
  void _deleteProduct(Product product) {
    final box = Hive.box<Product>('productBox');
    box.delete(product.productId); // Assuming `productId` is unique
  }
}
