// import 'package:flutter/material.dart';

// class CashierDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobile = screenWidth < 600;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Text(
//           'Cashier Dashboard',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               // Handle logout logic
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Section
//             Container(
//               width: double.infinity,
//               color: Colors.teal,
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Welcome, Cashier!',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Let’s make today productive!',
//                     style: TextStyle(fontSize: 16, color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),

//              // Daily Sales Overview
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Daily Sales Overview',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal, // Enable horizontal scrolling
//                 child: Row(
//                   children: [
//                     OverviewCard(
//                       title: 'Revenue',
//                       value: '\$1,200',
//                       color: Colors.green,
//                     ),
//                     OverviewCard(
//                       title: 'Transactions',
//                       value: '45',
//                       color: Colors.blue,
//                     ),
//                     OverviewCard(
//                       title: 'Pending',
//                       value: '2',
//                       color: Colors.orange,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Quick Actions
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Quick Actions',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Wrap(
//                 spacing: 16.0,
//                 runSpacing: 16.0,
//                 alignment: WrapAlignment.spaceAround,
//                 children: [
//                   QuickActionButton(
//                     icon: Icons.add_shopping_cart,
//                     label: 'New Sale',
//                     onPressed: () {
//                       // Navigate to new sale page
//                     },
//                   ),
//                   QuickActionButton(
//                     icon: Icons.list_alt,
//                     label: 'Pending Sales',
//                     onPressed: () {
//                       // Navigate to pending sales
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             // Inventory Alerts
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Inventory Alerts',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(horizontal: 16.0),
//               child: ListTile(
//                 leading: Icon(Icons.warning, color: Colors.red),
//                 title: Text('Low Stock Items'),
//                 subtitle: Text('5 items need restocking'),
//                 trailing: ElevatedButton(
//                   onPressed: () {
//                     // Navigate to inventory page
//                   },
//                   child: Text('View'),
//                 ),
//               ),
//             ),

//             // Footer
//             SizedBox(height: 16),
//             Center(
//               child: Text(
//                 'App Version: 1.0.0',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Custom Widget for Overview Cards
// class OverviewCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final Color color;

//   OverviewCard({required this.title, required this.value, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final cardWidth = screenWidth < 600 ? screenWidth / 2 - 32 : 100;

//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         width: cardWidth.toDouble(), // Cast to double
//         height: 100,
//         padding: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.2),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               title,
//               style: TextStyle(fontSize: 14, color: Colors.black87),
//             ),
//           ],
//         ),
//       ),
//     );

//   }
// }

// // Custom Widget for Quick Action Buttons
// class QuickActionButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onPressed;

//   QuickActionButton(
//       {required this.icon, required this.label, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             shape: CircleBorder(),
//             padding: EdgeInsets.all(16.0),
//           ),
//           onPressed: onPressed,
//           child: Icon(icon, size: 32),
//         ),
//         SizedBox(height: 8),
//         Text(
//           label,
//           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pos_sales_app/presentation/product_list.dart';
import 'package:pos_sales_app/presentation/sales_history.dart';

class CashierDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cashier Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.black,
            onPressed: () {
              // Show notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.red.shade900,
            onPressed: () {
              // Handle logout
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Start new sale
        },
        child: Icon(Icons.add_shopping_cart),
        tooltip: 'New Sale',
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Text(
              'POS Menu',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          _buildDrawerItem(Icons.add_shopping_cart, 'New Sale', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductListScreen()),
            );
          }),
          _buildDrawerItem(Icons.history, 'Sales History', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SalesHistoryScreen()),
            );
          }),
          _buildDrawerItem(Icons.analytics, 'Daily Summary', () {}),
          _buildDrawerItem(Icons.settings, 'Settings', () {}),
          _buildDrawerItem(Icons.logout, 'Logout', () {}),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key Metrics Section
          _buildMetricsSection(),

          SizedBox(height: 20),

          // Quick Actions Section
          _buildQuickActions(context),

          SizedBox(height: 20),

          // Sales Chart
          _buildSalesChart(),

          SizedBox(height: 20),

          // Low Stock Notification
          _buildLowStockNotification(),

          SizedBox(height: 20),

          // Notification Center
          _buildNotificationCenter(),
        ],
      ),
    );
  }

  Widget _buildMetricsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMetricCard('Total Sales', '\$4,560'),
        _buildMetricCard('Customers', '45'),
        _buildMetricCard('Items Sold', '234'),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: 100,
        child: Column(
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(value,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Navigate to New Sale
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductListScreen()),
            );
          },
          icon: Icon(Icons.add_shopping_cart),
          label: Text(
            'New Sale',
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.tealAccent),
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Navigate to Sales History
          },
          icon: Icon(Icons.history),
          label: Text(
            'Sales History',
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildSalesChart() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: EdgeInsets.all(16.0),
        height: 200,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
            titlesData: FlTitlesData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 1),
                  FlSpot(1, 3),
                  FlSpot(2, 2),
                  FlSpot(3, 1.5),
                  FlSpot(4, 3.5),
                ],
                isCurved: true,
                color: Colors.teal,
                barWidth: 4,
                isStrokeCapRound: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLowStockNotification() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(Icons.warning, color: Colors.red),
        title: Text('Low Stock Items Detected'),
        subtitle: Text('5 items are running low on stock.'),
        trailing: ElevatedButton(
          onPressed: () {
            // Handle low stock action
          },
          child: Text(
            'View',
            style: TextStyle(color: Colors.teal),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCenter() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(Icons.notifications, color: Colors.orange),
        title: Text('Pending Returns or Discount Approvals'),
        trailing: ElevatedButton(
          onPressed: () {
            // Handle action
          },
          child: Text(
            'View',
            style: TextStyle(color: Colors.teal),
          ),
        ),
      ),
    );
  }
}
