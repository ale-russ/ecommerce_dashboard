import 'package:ecommerce_dashboard/widget/card_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('dashboard page')
              // CardDashboard(
              //   cardName: 'test',
              //   cardColor: Color.fromARGB(255, 60, 54, 45),
              //   points: 20,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
