import 'package:flutter/material.dart';
import 'color_schemes.g.dart';
import 'constants.dart';
import 'package:provider/provider.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class CurrentPage extends ChangeNotifier {
  int currentIndex = 0;

  void changePage(int route) {
    currentIndex = route;
  }
}

class _MainNavigationBarState extends State<MainNavigationBar> {

  void openPage(int index) {
    switch(index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/second');
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
