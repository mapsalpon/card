import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentPage extends ChangeNotifier {
  int currentIndex = 0;

  void changePage(int route) {
    currentIndex = route;
  }
}

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {

  void openPage(int index) {
    switch(index) {
      case 0:
        Navigator.restorablePushReplacementNamed(context, '/');
        break;
      case 1:
        Navigator.restorablePushReplacementNamed(context, '/second');
        break;
      case 2:
        Navigator.restorablePushReplacementNamed(context, '/third');
        break;
    };
  }

  @override
  Widget build(BuildContext context) {
    var pageNumber = Provider.of<CurrentPage>(context);

    return Theme(
      data: Theme.of(context).copyWith(
        navigationBarTheme: NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: 72,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
        ),
      ),
      child: NavigationBar(
        height: 64,
        selectedIndex: pageNumber.currentIndex,
        onDestinationSelected: (int newIndex){
          pageNumber.changePage(newIndex);
          openPage(newIndex);
        },
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



