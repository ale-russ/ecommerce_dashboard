// import 'dart:developer';

// import 'package:ecommerce_dashboard/constants/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:go_router/go_router.dart';

// import '../account_page/account_page.dart';
// import '../dashboard/dashboard_page.dart';
// import '../orders_page/orders_page.dart';
// import '../product_page/product_page.dart';
// import 'controller/home_page_controller.dart';

// class HomePage extends ConsumerStatefulWidget {
//   HomePage({
//     Key? key,
//     this.child,
//   }) : super(key: key);

//   Widget? child;

//   @override
//   ConsumerState<HomePage> createState() => HomepageState();
// }

// class HomepageState extends ConsumerState<HomePage> {
//   // int _selectedIndex = 0;

//   // void _onItemTapped(int index) {
//   //   setState(() {
//   //     _selectedIndex = index;
//   //   });
//   // }

//   final user = FirebaseAuth.instance.currentUser!;

//   @override
//   Widget build(BuildContext context) {
//     log('child: ${{widget.child}}');
//     return Scaffold(
//       backgroundColor: bgColor,
//       // body: _getBodyWidget(),
//       body: widget.child,
//       bottomNavigationBar: const BottomNavigationWidget(),
//     );
//   }

//   // Widget _getBodyWidget() {
//   //   switch (_selectedIndex) {
//   //     case 0:
//   //       return const Dashboardpage();
//   //     case 1:
//   //       return const Orderpage();
//   //     case 2:
//   //       return ProductPage();
//   //     case 3:
//   //       return const AccountPage();
//   //     default:
//   //       return const SizedBox.shrink();
//   //   }
//   // }
// }

// class BottomNavigationWidget extends ConsumerWidget {
//   const BottomNavigationWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final index = ref.watch(bottomNavigationProvider);

//     return BottomNavigationBar(
//       currentIndex: index,
//       selectedItemColor: Colors.amber,
//       unselectedItemColor: Colors.black,
//       onTap: (value) {},
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.dashboard),
//           label: 'Dashboard',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.bookmark),
//           label: 'Orders',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.production_quantity_limits),
//           label: 'Products',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }

//   void _onTap(BuildContext context, int index, WidgetRef ref) {
//     log('onTap');
//     ref.read(bottomNavigationProvider.notifier).setIndex(index);

//     switch (index) {
//       case 0:
//         context.go('/');
//         break;
//       case 1:
//         context.go('/order');
//         break;
//       case 2:
//         context.go('/product-page');
//         break;
//       case 3:
//         context.go('/account');
//         break;
//       default:
//     }
//   }
// }

import 'package:ecommerce_dashboard/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../account_page/account_page.dart';
import '../dashboard/dashboard_page.dart';
import '../orders_page/orders_page.dart';
import '../product_page/product_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  ConsumerState<HomePage> createState() => HomepageState();
}

class HomepageState extends ConsumerState<HomePage> {
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
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: 'Products',
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
        return const Dashboardpage();
      case 1:
        return const Orderpage();
      case 2:
        return ProductPage();
      case 3:
        return const AccountPage();
      default:
        return const SizedBox.shrink();
    }
  }
}
