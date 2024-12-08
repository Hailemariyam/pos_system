import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedReport = 'Sales Report';
  final List<String> _reportTypes = [
    'Sales Report',
    'Inventory Report',
    'Performance Report'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedReport,
              decoration: InputDecoration(
                labelText: 'Select Report Type',
                labelStyle: TextStyle(color: Colors.teal, fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: _reportTypes.map((report) {
                return DropdownMenuItem<String>(
                  value: report,
                  child: Text(report),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedReport = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildReportContent(_selectedReport),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportContent(String reportType) {
    switch (reportType) {
      case 'Sales Report':
        return _buildSalesReport();
      case 'Inventory Report':
        return _buildInventoryReport();
      case 'Performance Report':
        return _buildPerformanceReport();
      default:
        return const Center(
          child: Text('No report available'),
        );
    }
  }

  Widget _buildSalesReport() {
    final data = [
      SalesData('Jan', 30),
      SalesData('Feb', 45),
      SalesData('Mar', 60),
    ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Monthly Sales Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: data.map((e) => _createBarGroup(e)).toList(),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < data.length) {
                            return Text(
                              data[index].month,
                              style: const TextStyle(fontSize: 12),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _createBarGroup(SalesData data) {
    final index = ['Jan', 'Feb', 'Mar'].indexOf(data.month);
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: data.sales.toDouble(),
          color: Colors.teal,
          width: 16,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildInventoryReport() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inventory Breakdown',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildInventoryTile('Product A', 20),
                  _buildInventoryTile('Product B', 15),
                  _buildInventoryTile('Product C', 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryTile(String product, int quantity) {
    return ListTile(
      leading: Icon(Icons.inventory, color: Colors.teal),
      title: Text(product),
      trailing: Text('$quantity units'),
    );
  }

  Widget _buildPerformanceReport() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildPerformanceTile('Employee A', 90),
                  _buildPerformanceTile('Employee B', 75),
                  _buildPerformanceTile('Employee C', 85),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceTile(String employee, int score) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.teal,
        child: Text(
          employee.substring(0, 1),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(employee),
      trailing: Text('$score%'),
    );
  }
}

class SalesData {
  final String month;
  final int sales;

  SalesData(this.month, this.sales);
}
