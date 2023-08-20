import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> displayExOh = ["", "", "", "", "", "", "", "", ""];
  bool oTurn = true; // The first player is O
  int oScore = 0;
  int xScore = 0;
  int filledBoxes=0;
  static var myFont=GoogleFonts.pressStart2p(textStyle: TextStyle(color: Colors.black,letterSpacing: 3));
  static var myNewFontWhite=GoogleFonts.pressStart2p(textStyle: TextStyle(color: Colors.white,letterSpacing: 3,fontSize: 15));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[700],
        body: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text('Player O', style: myNewFontWhite),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            oScore.toString(),
                            style: myNewFontWhite,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text('Player X', style: myNewFontWhite),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            xScore.toString(),
                            style: myNewFontWhite,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[800]!)),
                        child: Center(
                          child: Text(
                            displayExOh[index],
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(child: Container())
          ],
        ));
  }

  void _tapped(int index) {
    if (oTurn && displayExOh[index] == "") {
      displayExOh[index] = "O";
      filledBoxes+=1;
    } else if (!oTurn && displayExOh[index] == "") {
      displayExOh[index] = "X";
      filledBoxes+=1;
    }
    oTurn = !oTurn;
    _checkWinner();
    setState(() {});
  }

  void _checkWinner() {
    // Check First Row
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }
    // Check Second Row
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {
      _showWinDialog(displayExOh[3]);
    }
    // Check Third Row
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }
    // Check First Column
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }
    // Check Second Column
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {
      _showWinDialog(displayExOh[1]);
    }
    // Check Third Column
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {
      _showWinDialog(displayExOh[2]);
    }
    // Check Diagonal First
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }
    // Check Diagonal Second
    if (displayExOh[2] == displayExOh[4] &&
        displayExOh[2] == displayExOh[6] &&
        displayExOh[2] != '') {
      _showWinDialog(displayExOh[2]);
    }
    else if(filledBoxes==9){
      _showDrawDialog();
    }
  }
void _showDrawDialog(){
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Well Played! DRAW"),
          actions: <Widget>[
            TextButton(
                child: const Text('Play Again'),
                onPressed: () {
                  clearScore();
                  Navigator.of(context).pop();
                })
          ],
        );
      });

 }
  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("W I N N E R!" + winner),
            actions: <Widget>[
              TextButton(
                  child: const Text('Play Again'),
                  onPressed: () {
                    clearScore();
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
    if (winner == 'O') {
      oScore += 1;
    } else {
      xScore += 1;
    }
  }

  void clearScore() {
    for (int i = 0; i < 9; i++) {
      displayExOh[i] = '';
    }
    filledBoxes=0;
    setState(() {});
  }
}
