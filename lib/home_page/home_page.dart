import 'package:ecommerce_dashboard/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../account_page/account.dart';
import '../dashboard/dashboard.dart';
import '../orders_page/orders.dart';
import '../product_page/product.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: _getBodyWidget(),
      bottomNavigationBar: Container(
        color: Colors.blue,
        child: BottomNavigationBar(
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.black,
          // fixedColor: Colors.amber,
          backgroundColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: 'products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _getBodyWidget() {
    switch (_selectedIndex) {
      case 0:
        return Dashboardpage();
      case 1:
        return Orderpage();
      case 2:
        return Productpage();
      case 3:
        return AccountPage();
      default:
        return SizedBox.shrink();
    }
  }
}
