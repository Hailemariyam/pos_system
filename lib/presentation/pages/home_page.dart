import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pos_sales_app/bloc/cubit_navigation.dart';
import 'package:pos_sales_app/presentation/cashier_dashboard.dart';
import 'package:pos_sales_app/presentation/inventory_screen.dart';
import 'package:pos_sales_app/presentation/manager_dashboard.dart';

import 'dart:developer';

import 'package:pos_sales_app/presentation/product_list.dart';
import 'package:pos_sales_app/presentation/report_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final PageController _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _bottomNavBarController =
      NotchBottomBarController(index: 0);

  final List<Widget> _pages = [
    ManagerDashboard(),
    ProductListScreen(),
    InventoryScreen(),
    ReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          _bottomNavBarController.jumpTo(index);
        },
        children: _pages,
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _bottomNavBarController,
        color: Colors.black,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 5,
        kBottomRadius: 28.0,
        notchColor: Colors.white,
        removeMargins: true,
        bottomBarWidth: 500,
        showShadow: false,
        durationInMilliSeconds: 300,
        itemLabelStyle: const TextStyle(
          fontSize: 10,
          color: Colors.teal, // Label color for all items
          fontWeight: FontWeight.bold, // Optional: Makes the text bold
        ),
        elevation: 1,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.dashboard, color: Colors.white),
            activeItem: Icon(Icons.dashboard, color: Colors.teal),
            itemLabel: 'Dashboard',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.shopping_cart, color: Colors.white),
            activeItem: Icon(Icons.shopping_cart, color: Colors.teal),
            itemLabel: 'Sales',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.inventory, color: Colors.white),
            activeItem: Icon(Icons.inventory, color: Colors.teal),
            itemLabel: 'Inventory',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.report, color: Colors.white),
            activeItem: Icon(Icons.report, color: Colors.teal),
            itemLabel: 'Reports',
          ),
        ],
        onTap: (index) {
          log('Current selected index: $index');
          _bottomNavBarController.jumpTo(index);
          _pageController.jumpToPage(index);
        },
        kIconSize: 24.0,
      ),
    );
  }
}
