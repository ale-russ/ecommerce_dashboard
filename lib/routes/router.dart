import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../account_page/account.dart';
import '../authenticate/auth_page.dart';
import '../dashboard/dashboard.dart';
import '../home_page/home_page.dart';
import '../orders_page/orders.dart';
import '../product_page/product.dart';

class AppRoutes {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const AuthPage();
        },
      ),
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return const HomePage();
          },
          routes: [
            GoRoute(
                path: '/dashboard',
                builder: (context, state) {
                  return Dashboardpage();
                }),
            GoRoute(
                path: '/orders',
                builder: (context, state) {
                  return const Orderpage();
                }),
            GoRoute(
                path: '/products',
                builder: (context, state) {
                  return Productpage();
                }),
            GoRoute(
              path: 'profile',
              builder: (context, state) {
                return const AccountPage();
              },
            )
          ]),
    ],
  );
}
