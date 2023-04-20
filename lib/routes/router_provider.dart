import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../account_page/account_page.dart';
import '../authenticate/auth_page.dart';
import '../authenticate/screens/login_page.dart';
import '../authenticate/screens/registration.dart';
import '../dashboard/dashboard_page.dart';
import '../home_page/home_page.dart';
import '../orders_page/orders_page.dart';
import '../product_page/screens/product.dart';
import '../product_page/widget/add_product.dart';
import 'go_router_notifier.dart';
import 'route_error_screen.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

final routerProvider = Provider<GoRouter>((ref) {
  final routerNotifer = ref.read(goRouterNotifierProvider);

  return GoRouter(
      navigatorKey: _rootNavigator,
      initialLocation: '/',
      refreshListenable: routerNotifer,
      redirect: (context, state) {
        final isLoggedIn = routerNotifer.isLoggedIn;
        final isGoingToLogin = state.subloc == '/login';

        if (!isLoggedIn && !isGoingToLogin) {
          return '/';
        }
        return null;
      },
      routes: [
        GoRoute(
            path: '/',
            name: 'auth-page',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                  child: AuthPage(
                key: state.pageKey,
              ));
            },
            routes: [
              GoRoute(
                path: 'login',
                name: 'login',
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: LoginPage());
                },
              ),
              GoRoute(
                path: 'registration',
                name: 'registration',
                pageBuilder: (context, state) {
                  return NoTransitionPage(child: RegistrationPage());
                },
              ),
              ShellRoute(
                  navigatorKey: _shellNavigator,
                  builder: (context, state, child) {
                    return HomePage(
                        // child: child,
                        );
                  },
                  routes: [
                    GoRoute(
                        path: '/',
                        name: 'dashboard',
                        pageBuilder: (context, state) {
                          return const NoTransitionPage(child: Dashboardpage());
                        }),
                    GoRoute(
                        path: '/orders',
                        name: 'orders',
                        pageBuilder: (context, state) {
                          return const NoTransitionPage(child: Orderpage());
                        }),
                    GoRoute(
                        path: '/products',
                        name: 'products',
                        pageBuilder: (context, state) {
                          return NoTransitionPage(child: Productpage());
                        },
                        routes: [
                          GoRoute(
                            path: 'products/:id',
                            name: 'add-products',
                            pageBuilder: (context, state) {
                              final id = state.params['id'].toString();
                              return NoTransitionPage(
                                child: AddProductPage(
                                  id: int.parse(id),
                                ),
                              );
                            },
                          )
                        ]),
                    GoRoute(
                      path: '/profile',
                      builder: (context, state) {
                        return const AccountPage();
                      },
                    ),
                  ])
            ]),
      ],
      errorBuilder: (context, state) {
        return RouteErrorScreen(
          errorMsg: state.error.toString(),
          key: state.pageKey,
        );
      });
});
