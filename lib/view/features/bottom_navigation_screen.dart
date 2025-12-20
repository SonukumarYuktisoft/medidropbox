import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medidropbox/routes/app_routes.dart';

class BottomNavigationScreen extends StatelessWidget {
  final Widget child;

  const BottomNavigationScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 0) {
            context.go(AppRoutes.dashboardScreen);
          } else if (index == 1) {
            context.go(AppRoutes.profile);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
