import 'package:flutter/material.dart';
import 'package:puzzle_15/widgets/button_group.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '15 Puzzle',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.app_registration_sharp,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(
              height: 40,
            ),
            ButtonGroup(),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
