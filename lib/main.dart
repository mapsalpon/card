import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'package:provider/provider.dart';
import 'navigation_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrentPage()),
      ],
      child: const MyApp(),
    ),
  );
}


