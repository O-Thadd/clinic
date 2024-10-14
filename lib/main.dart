import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:clinic/home_screen.dart';
import 'package:clinic/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());

  doWhenWindowReady(() {
    const initialSize = Size(1000, 725);
    const minSize = Size(670, 725);
    appWindow.minSize = minSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(colorScheme: oziDarkColorScheme, textTheme: oziTextTheme),
      home: Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.surface,
          child: HomeScreen(patients: [])
        ),
      ),
    );
  }
}
