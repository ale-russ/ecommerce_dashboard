// import 'dart:developer';

// import 'package:ecommerce_dashboard/authenticate/screens/registration.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../account_page/account_page.dart';
// import '../authenticate/screens/auth_page.dart';
// import '../authenticate/screens/login_page.dart';
// import '../dashboard/dashboard_page.dart';
// import '../home_page/home_page.dart';
// import '../orders_page/orders_page.dart';
// import '../product_page/screens/product.dart';
// import '../product_page/widget/add_product.dart';

// class AppRoutes {
//   static final _rootNavigatorKey = GlobalKey<NavigatorState>();
//   static final _shellNavigatorKey = GlobalKey<NavigatorState>();

//   GoRouter router = GoRouter(
//     navigatorKey: _rootNavigatorKey,
//     initialLocation: '/',
//     redirect: (context, state) async {},
//     routes: [
//       // GoRoute(
//       //   path: '/',
//       //   builder: (context, state) {
//       //     return const AuthPage();
//       //   },
//       // ),
//       // routes: [
//       GoRoute(
//         path: '/',
//         builder: (context, state) {
//           return const LoginPage();
//         },
//       ),
//       GoRoute(
//         path: '/registration',
//         builder: (context, state) {
//           return RegistrationPage();
//         },
//       ),

//       ShellRoute(
//         navigatorKey: _shellNavigatorKey,
//         pageBuilder: (context, state, child) {
//           return NoTransitionPage(
//               child: HomePage(
//             key: state.pageKey,
//             child: child,
//           ));
//         },
//         routes: [
//           GoRoute(
//               parentNavigatorKey: _shellNavigatorKey,
//               path: '/',
//               name: 'dashboard',
//               builder: (context, state) {
//                 return const Dashboardpage();
//               }),
//           GoRoute(
//               parentNavigatorKey: _shellNavigatorKey,
//               path: '/orders',
//               name: 'orders',
//               builder: (context, state) {
//                 return const Orderpage();
//               }),
//           GoRoute(
//               parentNavigatorKey: _shellNavigatorKey,
//               path: '/products',
//               name: 'products',
//               builder: (context, state) {
//                 return Productpage();
//               },
//               routes: [
//                 GoRoute(
//                   path: 'add-products',
//                   name: 'add-products',
//                   builder: (context, state) {
//                     return const AddProductPage();
//                   },
//                 )
//               ]),
//           GoRoute(
//             parentNavigatorKey: _shellNavigatorKey,
//             path: '/profile',
//             name: 'profile',
//             builder: (context, state) {
//               return const AccountPage();
//             },
//           ),
//         ],
//       ),
//       // ]),
//     ],
//   );
// }
