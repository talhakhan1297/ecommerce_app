import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(
            label: 'Products',
            icon: Icon(Icons.list),
          ),
          NavigationDestination(
            label: 'Cart',
            icon: Icon(Icons.shopping_bag_outlined),
          ),
          NavigationDestination(
            label: 'Profile',
            icon: Icon(Icons.person_2_outlined),
          ),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
