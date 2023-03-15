import 'package:flutter/material.dart';
import 'color_schemes.g.dart';
import 'constants.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {

  int currentIndex = 0;

  void goToRoute(int route) {
    setState(() {
      currentIndex = route;
    });
    switch(route) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/second');
        break;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        navigationBarTheme: NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: 72,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
        ),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: goToRoute,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_filled), label: 'Главная'),
          NavigationDestination(
              icon: Icon(Icons.calendar_month), label: 'Ежедневные'),
          NavigationDestination(
              icon: Icon(Icons.collections_bookmark_sharp),
              label: 'Расклады'),
        ],
      ),
    );
  }
}
