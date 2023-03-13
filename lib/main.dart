import 'package:flutter/material.dart';
import 'package:puzzle_15/screens/main_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0XFF57407C),
        textTheme: TextTheme(
          titleLarge: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
          bodyLarge: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w700,
              shadows: <Shadow>[
                Shadow(
                  offset: const Offset(4, 2),
                  blurRadius: 16.0,
                  color: Colors.black87.withOpacity(.6),
                ),
                Shadow(
                  offset: const Offset(-2, -4),
                  blurRadius: 16.0,
                  color: Colors.black87.withOpacity(.6),
                ),
              ]),
        ),
        splashColor: const Color(0xff3d2963),
      ),
      title: '15 Puzzle',
      home: const MainScreen(),
    );
  }
}
