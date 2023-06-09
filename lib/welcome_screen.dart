import 'package:flutter/material.dart';
import 'color_schemes.g.dart';
import 'constants.dart';
import 'daily_event.dart';
import 'navigation_bar.dart';
import 'session_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/second': (context) => const DailyEventPage(),
        '/third': (context) => const SessionPage(),
      },
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final eventCardWidth = screenWidth / 2 - 16;
  late final eventCardHeight = eventCardWidth * pixelRatio / 2;

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
            icon: const Icon(Icons.settings_outlined),
            splashRadius: 0.1,
          ),
        ],
      ),
      bottomNavigationBar: const MainNavigationBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  height: eventCardHeight,
                  width: eventCardWidth,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  height: eventCardHeight,
                  width: eventCardWidth,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Center(
              child: Text(
                'Таро реально погадай',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: screenWidth,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 24, right: 24, left: 24),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    minimumSize: const MaterialStatePropertyAll(Size(0, 50)),
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.secondaryContainer),
                    elevation: MaterialStatePropertyAll(10),
                    shadowColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
                  ),
                  child: const Text(
                    'Новый расклад',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
