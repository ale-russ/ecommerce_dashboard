// import 'package:ecommerce_dashboard/authenticate/screens/registration.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../account_page/account_page.dart';
// // import '../authenticate/auth_page.dart';
// import '../authenticate/screens/login_page.dart';
// import '../dashboard/dashboard_page.dart';
// import '../home_page/home_page.dart';
// import '../orders_page/orders_page.dart';
// import '../product_page/screens/product.dart';
// import '../product_page/screens/product_page.dart';
// import '../product_page/widget/add_product.dart';

// class AppRoutes {
//   static final _rootNavigatorKey = GlobalKey<NavigatorState>();
//   static final _shellNavigatorKey = GlobalKey<NavigatorState>();
//   GoRouter router = GoRouter(
//     navigatorKey: _rootNavigatorKey,
//     // initialLocation: '/',
//     routes: [
//       GoRoute(
//           path: '/',
//           builder: (context, state) {
//             return const AuthPage();
//           },
//           routes: [
//             GoRoute(
//               path: 'login',
//               builder: (context, state) {
//                 return LoginPage();
//               },
//             ),
//             GoRoute(
//               path: 'registration',
//               builder: (context, state) {
//                 return RegistrationPage();
//               },
//             ),
//             GoRoute(
//                 path: 'homePage',
//                 builder: (context, state) {
//                   return const HomePage();
//                 },
//                 routes: [
//                   ShellRoute(
//                     navigatorKey: _shellNavigatorKey,
//                     builder: (context, state, child) {
//                       return child;
//                     },
//                     routes: [
//                       GoRoute(
//                           path: 'dashboard',
//                           builder: (context, state) {
//                             return Dashboardpage();
//                           }),
//                       GoRoute(
//                           path: 'orders',
//                           builder: (context, state) {
//                             return const Orderpage();
//                           }),
//                       GoRoute(
//                           name: 'products',
//                           path: 'products',
//                           builder: (context, state) {
//                             return ProductPage();
//                           },
//                           routes: [
//                             GoRoute(
//                               name: 'add-products',
//                               path: 'add-products',
//                               builder: (context, state) {
//                                 return const AddProductPage();
//                               },
//                             )
//                           ]),
//                       GoRoute(
//                         path: 'profile',
//                         builder: (context, state) {
//                           return const AccountPage();
//                         },
//                       ),
//                     ],
//                   ),
//                 ]),
//           ]),

//       // ShellRoute(
//       //   navigatorKey: _shellNavigatorKey,
//       //   builder: (context, state, child) {
//       //     return const HomePage();
//       //   },
//       //   routes: [
//       //     GoRoute(
//       //         path: 'dashboard',
//       //         builder: (context, state) {
//       //           return Dashboardpage();
//       //         }),
//       //     GoRoute(
//       //         path: '/orders',
//       //         builder: (context, state) {
//       //           return const Orderpage();
//       //         }),
//       //     GoRoute(
//       //         path: '/products',
//       //         builder: (context, state) {
//       //           return Productpage();
//       //         },
//       //         routes: [
//       //           GoRoute(
//       //             path: 'add-products',
//       //             builder: (context, state) {
//       //               return const AddProductPage();
//       //             },
//       //           )
//       //         ]),
//       //     GoRoute(
//       //       path: '/profile',
//       //       builder: (context, state) {
//       //         return const AccountPage();
//       //       },
//       // ),

//       // ],
//       // ),
//     ],
//   );
// }
