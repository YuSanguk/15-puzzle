import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameScreen extends StatefulWidget {
  final int? level;

  const GameScreen({
    super.key,
    required this.level,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _containerKey = GlobalKey();
  static const List<String> options = ["3X3", "4X4"];
  static double boxHeight = 30;
  late int level = 4;

  static const List<int> dx = [0, 1, 0, -1];
  static const List<int> dy = [1, 0, -1, 0];

  late List<List<int>> map = [
    [0]
  ];
  late SharedPreferences prefs;

  late int _currentCnt = 0;
  late int _bestCnt = 0;

  // function get gameBoard's width.
  void _getSize() async {
    final size = _containerKey.currentContext?.size;
    if (size != null) {
      setState(() {
        final double width = size.width;
        boxHeight = width / level;
      });
    }
  }

  void createMap() {
    map = List.generate(
        level, (i) => List.generate(level, (j) => i * level + j + 1));
    List<int> virtualMap = List.generate(level * level, (i) => i + 1);
    virtualMap.shuffle();
    for (var i = 0; i < level; i++) {
      for (var j = 0; j < level; j++) {
        map[i][j] = virtualMap[i * level + j];
      }
    }
  }

  Future initSettings() async {
    // using pref
    prefs = await SharedPreferences.getInstance();
    if (widget.level != null) {
      // newGame
      level = widget.level!;
      createMap();
    }

    // Load Best Score
    final bestCnt = prefs.getInt('bestCnt');
    if (bestCnt != null) {
      _bestCnt = bestCnt;
    } else {
      _bestCnt = 0;
      await prefs.setInt('bestCnt', 0);
    }

    // get GameBoard's Width
    _getSize();
  }

  void checker() {
    var cnt = 0; //check how many puzzle isCorrect
    for (var i = 0; i < level; i++) {
      for (var j = 0; j < level; j++) {
        if (map[i][j] == i * level + j + 1) {
          cnt += 1;
        }
      }
    }

    // when game clear
    if (cnt == level * level) {
      // Update Best Record
      if (_currentCnt <= _bestCnt || _bestCnt == 0) {
        prefs.setInt('bestCnt', _currentCnt);
      }
      // Return main_screen
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      initSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          options[level - 3],
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentCnt = 0;
                    // updateData();
                    createMap();
                  });
                },
                icon: const Icon(
                  Icons.restart_alt_rounded,
                  color: Color(0xFFEEEEEE),
                  size: 40,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).splashColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                    child: Text(
                  'BEST : ${_bestCnt.toString()}  /  MOVE : ${_currentCnt.toString()}',
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
              ),
            ]),
            const SizedBox(
              height: 70,
            ),
            Container(
              key: _containerKey,
              height: boxHeight * level,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).splashColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(map.length, (i) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(map[i].length, (j) {
                      return GestureDetector(
                        onTap: () {
                          if (map[i][j] == level * level) {
                            return;
                          }
                          for (var l = 0; l < 4; l++) {
                            var tx = j + dx[l];
                            var ty = i + dy[l];
                            if (ty >= 0 &&
                                ty < level &&
                                tx < level &&
                                tx >= 0) {
                              if (map[ty][tx] == level * level) {
                                setState(() {
                                  var tmp = map[ty][tx];
                                  map[ty][tx] = map[i][j];
                                  map[i][j] = tmp;
                                  _currentCnt += 1;
                                  checker();
                                });
                                break;
                              }
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: map[i][j] != level * level
                                ? i * level + j + 1 == map[i][j]
                                    ? Colors.amber[600]
                                    : Colors.lightBlue
                                : Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: boxHeight - 12,
                          height: boxHeight - 12,
                          child: Center(
                            child: Text(
                              map[i][j] != level * level
                                  ? map[i][j].toString()
                                  : "",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
