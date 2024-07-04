import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CostomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CostomBottomNavigation({super.key, required this.navigationShell});

  int getCurrentIndex(BuildContext context) {
    final dynamic location = GoRouterState.of(context).fullPath;
    switch (location) {
      case '/':
        return 0;

      case '/cities':
        return 1;

      case '/theme':
        return 2;

      default:
        return 0;
    }
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/cities');
        break;
      case 2:
        context.go('/theme');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_city), label: 'cities'),
          BottomNavigationBarItem(icon: Icon(Icons.colorize), label: 'Theme'),
        ],
        currentIndex: getCurrentIndex(context),
        onTap: (value) => onItemTapped(context, value),
      ),
    );
  }
}
