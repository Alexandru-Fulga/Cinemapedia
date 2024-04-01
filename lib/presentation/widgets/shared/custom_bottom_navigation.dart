import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;

    switch (location) {
      case '/':
        return 0;
      case '/popular':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0;
    }
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go("/");
        break;
      case 1:
        context.go("/popular");
        break;
      case 2:
        context.go("/favorites");
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (value) => onItemTapped(context, value),
      selectedIndex: getCurrentIndex(context),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_max_outlined),
          label: 'Inicio',
        ),
        NavigationDestination(
          icon: Icon(Icons.label_outline),
          label: 'Populares',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
