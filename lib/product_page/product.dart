import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Productpage extends ConsumerWidget {
  const Productpage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          child: Text(
            'product page',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
