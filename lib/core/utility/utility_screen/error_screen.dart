 import 'package:flutter/material.dart';

// Error Screen
class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen({super.key, this.error});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Route Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(error?.toString() ?? 'Unknown error'),
            const SizedBox(height: 24),
            ElevatedButton(
              // onPressed: () => context.goNamed(AppRoutesName.splashView),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[900],
              ),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
