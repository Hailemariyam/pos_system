// admin_page.dart
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, Admin!'),
            ElevatedButton(
              onPressed: () {
                // Navigate to User Management screen
                Navigator.pushNamed(context, '/user_management');
              },
              child: Text('Manage Users'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to Settings screen
                Navigator.pushNamed(context, '/settings');
              },
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
