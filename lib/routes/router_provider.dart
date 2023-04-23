import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../authenticate/providers/auth_state_change_provider.dart';
import '../authenticate/screens/auth_page.dart';
import '../authenticate/screens/login_page.dart';
import '../authenticate/screens/registration.dart';
import '../dashboard/screens/dashboard_page.dart';
import '../home/screen/home_page.dart';
import '../models/product.dart';
import '../orders/screen/orders_page.dart';
import '../product/screens/product_page.dart';
import '../product/screens/products_detali.dart';
import '../product/screens/add_product.dart';
import '../account/screens/account_page.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

final routerProvider = Provider<GoRouter>((ref) {
  var isLoggedIn = ref.watch(loggedIn);

  return GoRouter(
      navigatorKey: _rootNavigator,
      initialLocation: '/',
      redirect: (context, state) {
        final isLoggingIn = state.subloc == '/login';
        final isRegistering = state.subloc == '/register';

        log('isLoggedIn: $isLoggedIn');

        if (!isLoggedIn && !isLoggingIn && !isRegistering) {
          return '/login';
        }
        if (!isLoggedIn && !isLoggingIn && isRegistering) {
          return '/register';
        }
        if (isLoggedIn && isLoggingIn || isRegistering) {
          return '/';
        }

        return null;
      },
      routes: [
        GoRoute(
            path: '/login',
            name: 'login',
            builder: (context, state) {
              return LoginPage(
                key: state.pageKey,
              );
            }),
        GoRoute(
            path: '/register',
            name: 'register',
            builder: (context, state) {
              return RegistrationPage(
                key: state.pageKey,
              );
            }),
        ShellRoute(
            navigatorKey: _shellNavigator,
            builder: (context, state, child) {
              return HomePage(
                key: state.pageKey,
                child: child,
              );
            },
            routes: [
              GoRoute(
                  parentNavigatorKey: _shellNavigator,
                  path: '/',
                  name: 'dashboard',
                  builder: (context, state) {
                    return const Dashboardpage();
                  }),
              GoRoute(
                  parentNavigatorKey: _shellNavigator,
                  path: '/orders',
                  name: 'orders',
                  builder: (context, state) {
                    return const Orderpage();
                  }),
              GoRoute(
                  parentNavigatorKey: _shellNavigator,
                  path: '/products',
                  name: 'products',
                  builder: (context, state) {
                    return ProductPage();
                  },
                  routes: [
                    GoRoute(
                      path: 'add-products',
                      name: 'add-products',
                      builder: (context, state) {
                        return const AddProductPage();
                      },
                    ),
                    GoRoute(
                      path: 'product-details',
                      name: 'product-details',
                      builder: (context, state) {
                        Product prods = state.extra! as Product;
                        return ProductDetailsPage(
                          key: state.pageKey,
                          product: prods,
                        );
                      },
                    )
                  ]),
              GoRoute(
                parentNavigatorKey: _shellNavigator,
                path: '/profile',
                name: 'profile',
                builder: (context, state) {
                  return const AccountPage();
                },
              ),
            ])
      ]);
});
