import 'package:flutter/material.dart';
import 'color_schemes.g.dart';
import 'constants.dart';
import 'navigation_bar.dart';

class DailyEventPage extends StatefulWidget {
  const DailyEventPage({Key? key}) : super(key: key);

  @override
  State<DailyEventPage> createState() => _DailyEventPageState();
}

class _DailyEventPageState extends State<DailyEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: IconThemeData(
          size: 32,
          color: Theme.of(context).colorScheme.secondary,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.stars_rounded),
            splashRadius: 0.1,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
            splashRadius: 0.1,
          ),
        ],
      ),
      bottomNavigationBar: MainNavigationBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[],
      ),
    );
  }
}
