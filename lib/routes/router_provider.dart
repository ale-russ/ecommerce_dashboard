import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../account_page/account_page.dart';
import '../authenticate/providers/auth_state_change_provider.dart';
import '../authenticate/screens/auth_page.dart';
import '../authenticate/screens/login_page.dart';
import '../authenticate/screens/registration.dart';
import '../dashboard/dashboard_page.dart';
import '../home_page/home_page.dart';
import '../models/product.dart';
import '../orders_page/orders_page.dart';
import '../product_page/screens/product.dart';
import '../product_page/screens/products_detali.dart';
import '../product_page/widget/add_product.dart';

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
        final isRegistering = state.subloc == '/registration';
        log('isLoggedIn: $isLoggedIn');
        if (!isLoggedIn && !isLoggingIn && !isRegistering) {
          return '/login';
        }
        if (isLoggedIn && isLoggingIn) {
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
            path: '/registration',
            name: 'registration',
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
                    return Productpage();
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
