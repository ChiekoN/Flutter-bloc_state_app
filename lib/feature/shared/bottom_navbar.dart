import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router.dart';

class ScaffoldWithBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Widget child;

  const ScaffoldWithBottomNavBar({
    super.key, 
    required this.currentIndex,
    required this.child
  });

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: destinations.map(
          (dest) => NavigationDestination(
            icon: dest.icon, 
            label: dest.label
          )
        ).toList(),
        onDestinationSelected: (int index) {
          context.go(destinations[index].route);
        },
      ),
      floatingActionButton: currentIndex == 0 ? FloatingActionButton(
        onPressed: () {
          context.go('/${AppRoutes.add}');
        },
        child: const Icon(Icons.add),
      ) : null,
    );
  }
}