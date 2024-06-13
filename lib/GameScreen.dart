import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() => runApp(SnakeGame());

class SnakeGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
  title: 'Snake Game',
  home: Scaffold(
    appBar: AppBar(
      title: Text(
        'Snake Game',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(245, 9, 20, 1),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
        color: Colors.white, // Set the color of the icon here
      ),
    ),
    body: Container(
      color: Colors.white, // Set the background color for the body here
      child: Snake(),
    ),
  ),
);

  }
}

class Snake extends StatefulWidget {
  @override
  _SnakeState createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  static const int gridSize = 20;
  static const int snakeSpeed = 150;
  List<int> snake = [45, 65]; // Initial snake position
  int food = 3; // Initial food position
  bool gameover = false;
  var direction = "down";
  int score = 0;

  void startGame() {
    const duration = Duration(milliseconds: snakeSpeed);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        gameOverScreen();
      }
    });
  }

  void updateSnake() {
    setState(() {
      switch (direction) {
        case "up":
          if (snake.first < gridSize) {
            snake.insert(0, snake.first - gridSize + (gridSize * gridSize));
          } else {
            snake.insert(0, snake.first - gridSize);
          }
          break;
        case "down":
          snake.insert(0, (snake.first + gridSize) % (gridSize * gridSize));
          break;
        case "left":
          // Adjust for wrapping around the left edge
          snake.insert(0, snake.first % gridSize == 0 ? snake.first - 1 + gridSize : snake.first - 1);
          break;
        case "right":
          // Adjust for wrapping around the right edge
          snake.insert(0, (snake.first + 1) % gridSize == 0 ? snake.first + 1 - gridSize : snake.first + 1);
          break;
      }
      if (snake.first == food) {
        // If snake eats food
        food = _generateFood();
        score++;
        if (score == 10) {
          // Display popup when score reaches 10
          showWinPopup();
        }
      } else {
        snake.removeLast();
      }
    });
  }

  int _generateFood() {
    final random = new Random();
    int randomNumber = random.nextInt(gridSize * gridSize - 1);
    while (snake.contains(randomNumber)) {
      randomNumber = random.nextInt(gridSize * gridSize - 1);
    }
    return randomNumber;
  }

  bool gameOver() {
    // Check if snake collides with itself
    if (snake.sublist(1).contains(snake.first)) {
      return true;
    }
    return false;
  }

  void gameOverScreen() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text("Score: $score"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                restartGame();
              },
              child: Text("Restart"),
            ),
          ],
        );
      },
    );
  }

  void restartGame() {
    setState(() {
      snake = [45, 65];
      food = 3;
      gameover = false;
      direction = "down";
      score = 0;
    });
    startGame();
  }

  void showWinPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Congratulations!"),
          content: Text("You won!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                restartGame(); // Restart the game
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: const Color.fromARGB(245, 9, 20, 1), // Background color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Score: $score',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color
              ),
            ),
            Expanded(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0 && direction != "up") {
                    direction = "down";
                  } else if (details.delta.dy < 0 && direction != "down") {
                    direction = "up";
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0 && direction != "left") {
                    direction = "right";
                  } else if (details.delta.dx < 0 && direction != "right") {
                    direction = "left";
                  }
                },
                child: Center(
                  child: Container(
                    color: Color.fromARGB(255, 255, 255, 255), // Background color for grid only
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridSize,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (snake.contains(index)) {
                          return Container(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                color: Colors.green,
                              ),
                            ),
                          );
                        } else if (food == index) {
                          return Image.asset(
                            'assets/images/apple.png', // Replace 'food.png' with your image asset path
                            fit: BoxFit.cover,
                          );
                        } else {
                          return Container(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Container(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          );
                        }
                      },
                      itemCount: gridSize * gridSize,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
