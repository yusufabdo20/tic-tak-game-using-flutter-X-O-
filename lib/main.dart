import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<List<String>> mtrx = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""]
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('X,O game')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GameElement(0, 0),
                  GameElement(0, 1),
                  GameElement(0, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GameElement(1, 0),
                  GameElement(1, 1),
                  GameElement(1, 2),
                ],
              ),
              Row(mainAxisSize: MainAxisSize.min, children: [
                GameElement(2, 0),
                GameElement(2, 1),
                GameElement(2, 2),
              ])
            ],
          ),
        ),
      ),
    );
  }

// End Build Function
  whoWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = mtrx.length - 1;
    var player = mtrx[x][y];
    for (int i = 0; i < mtrx.length; i++) {
      if (mtrx[x][i] == player) {
        col++;
      }
      if (mtrx[i][y] == player) {
        col++;
      }
      if (mtrx[i][i] == player) {
        diag++;
      }
      if (mtrx[i][n - i] == player) {
        rdiag++;
      }
      if (col == n + 1 || row == n + 1 || diag == n + 1 || rdiag == n + 1) {
        // User Attention Who wins
        showDialog(
            context: context,
            builder: (BuildContext cont) => AlertDialog(
                  title: Text("$player is Winner !"),
                  content: Text("Restart Game ? "),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(cont).pop(cont);
                            mtrx = [
                              ["", "", ""],
                              ["", "", ""],
                              ["", "", ""]
                            ];
                          });
                        },
                        child: Text("ok"))
                  ],
                ));
      }
    }
  }

  String xO = 'x';
  Container GameElement(int row, int col) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: TextButton(
            onPressed: () {
              if (mtrx[row][col].isEmpty) {
                setState(() {
                  mtrx[row][col] = xO;
                  if (xO == 'x') {
                    xO = 'o';
                  } else {
                    xO = 'x';
                  }
                  whoWinner(row, col);
                });
              }
            },
            child: Text(
              mtrx[row][col],
              style: TextStyle(color: Colors.black, fontSize: 60),
            )));
  }
}
