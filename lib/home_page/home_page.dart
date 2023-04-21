import 'dart:developer';

import 'package:ecommerce_dashboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'controller/home_page_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedIndex = ref.watch(bottomNavigationProvider);

    return Scaffold(
      backgroundColor: bgColor,
      body: child,
      bottomNavigationBar: BottomNavigationWidget(selectedIndex: selectedIndex),
    );
  }
}

class BottomNavigationWidget extends ConsumerWidget {
  const BottomNavigationWidget({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (value) => _onTap(context, value, ref),
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
    );
  }

  void _onTap(BuildContext context, int index, WidgetRef ref) {
    ref.read(bottomNavigationProvider.notifier).setIndex(index);
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/orders');
        break;
      case 2:
        context.go('/products');
        break;
      case 3:
        context.go('/profile');
        break;

      default:
    }
  }
}
