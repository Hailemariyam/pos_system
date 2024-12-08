import 'package:flutter/material.dart';

class ManagerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.tealAccent,
        title: Text(
          'Manager Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Handle logout logic
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              _buildWelcomeSection(),

              // Daily Sales Overview Section
              _buildDailySalesOverview(),

              // Inventory Status Section
              _buildInventoryStatus(),

              // Quick Actions Section
              _buildQuickActions(),

              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Welcome Section Widget
  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      color: Colors.teal,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, Manager!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Monitor performance and manage the business efficiently.',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Daily Sales Overview Section
  Widget _buildDailySalesOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Daily Sales Overview',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildOverviewCard('Total Revenue', '\$1,500', Colors.green),
              _buildOverviewCard('Transactions', '50', Colors.blue),
              _buildOverviewCard('Cashier Breakdown', 'Details', Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  // Inventory Status Section
  Widget _buildInventoryStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Inventory Status',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Icon(Icons.inventory, color: Colors.greenAccent),
            title: Text('Stock Levels'),
            subtitle: Text('View current stock levels and low stock alerts'),
            trailing: Icon(Icons.arrow_forward, color: Colors.greenAccent),
            onTap: () {
              // Navigate to inventory management
            },
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Icon(Icons.warning, color: Colors.red),
            title: Text('Low Stock Alerts'),
            subtitle: Text('Items that need to be restocked soon'),
            trailing: Icon(Icons.arrow_forward, color: Colors.red),
            onTap: () {
              // Navigate to low-stock items
            },
          ),
        ),
      ],
    );
  }

  // Quick Actions Section
  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Quick Actions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildQuickActionButton(Icons.add_box, 'Add Inventory'),
            _buildQuickActionButton(Icons.report, 'View Reports'),
            _buildQuickActionButton(Icons.person_add, 'Manage Cashiers'),
          ],
        ),
      ],
    );
  }

  // Overview Card for Sales Data
  Widget _buildOverviewCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 200,
        height: 100,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // Quick Action Button for Quick Actions
  Widget _buildQuickActionButton(IconData icon, String label) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: Colors.teal,
            padding: EdgeInsets.all(16.0),
          ),
          onPressed: () {
            // Handle action
          },
          child: Icon(icon, size: 32, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
