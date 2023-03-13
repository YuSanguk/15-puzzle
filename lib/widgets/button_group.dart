import 'package:flutter/material.dart';
import 'package:puzzle_15/screens/game_screen.dart';

class ButtonGroup extends StatelessWidget {
  const ButtonGroup({super.key});
  static final List<String> _options = ["3X3", "4X4"];
  static final List<int> _values = [3, 4];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_options.length, (index) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(
                    level: _values[index],
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF386cf1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              height: 60.0,
              margin: const EdgeInsets.all(6.5),
              child: Center(
                child: Text(
                  _options[index],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
