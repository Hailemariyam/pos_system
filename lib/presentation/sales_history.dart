import 'package:flutter/material.dart';

class SalesHistoryScreen extends StatelessWidget {
  // Sample sales data
  final List<Map<String, dynamic>> salesData = [
    {
      'id': 1,
      'date': '2024-12-01',
      'amount': 250.0,
      'customer': 'John Doe',
      'items': 3
    },
    {
      'id': 2,
      'date': '2024-12-02',
      'amount': 450.0,
      'customer': 'Alice Smith',
      'items': 5
    },
    {
      'id': 3,
      'date': '2024-12-03',
      'amount': 150.0,
      'customer': 'Bob Johnson',
      'items': 2
    },
    {
      'id': 4,
      'date': '2024-12-04',
      'amount': 350.0,
      'customer': 'Carol White',
      'items': 4
    },
    // Add more sample data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales History'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Filter logic can be implemented
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              // Desktop or large tablet layout
              return _buildDesktopLayout(context);
            } else {
              // Mobile layout
              return _buildMobileLayout(context);
            }
          },
        ),
      ),
    );
  }

  // Desktop layout with table and filter section
  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterSection(),
        SizedBox(height: 16),
        Expanded(child: _buildSalesHistoryTable(context)),
      ],
    );
  }

  // Mobile layout with stacked cards for sales history and filter section
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterSection(),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: salesData.length,
            itemBuilder: (context, index) {
              var sale = salesData[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Text(sale['id'].toString(),
                        style: TextStyle(color: Colors.white)),
                  ),
                  title: Text('Sale on ${sale['date']}'),
                  subtitle: Text(
                      'Customer: ${sale['customer']} - Total: \$${sale['amount']}'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Show sale details
                    _showSaleDetails(context, sale);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Filter Section UI
  Widget _buildFilterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Filter logic can be implemented
          },
          icon: Icon(Icons.calendar_today),
          label: Text('Date Filter'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Sort sales data logic
          },
          icon: Icon(Icons.sort),
          label: Text('Sort'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        ),
      ],
    );
  }

  // Sales History Table (for desktop)
  Widget _buildSalesHistoryTable(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Sale ID')),
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('Items')),
      ],
      rows: salesData
          .map(
            (sale) => DataRow(cells: [
              DataCell(Text(sale['id'].toString())),
              DataCell(Text(sale['date'])),
              DataCell(Text(sale['customer'])),
              DataCell(Text('\$${sale['amount']}')),
              DataCell(Text(sale['items'].toString())),
            ]),
          )
          .toList(),
    );
  }

  // Show Sale Details
  void _showSaleDetails(BuildContext context, Map<String, dynamic> sale) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sale Details'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Customer: ${sale['customer']}'),
            Text('Date: ${sale['date']}'),
            Text('Items Sold: ${sale['items']}'),
            Text('Amount: \$${sale['amount']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
