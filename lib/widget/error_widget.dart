import 'package:flutter/material.dart';

class adminErrorWidget extends StatelessWidget {
  const adminErrorWidget({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            const Text('No results',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text(
                'Sorry something went wrong, there are no results try again later.',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.blue,
      ),
    );
  }
}
