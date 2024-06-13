import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'GameScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Button Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ButtonScreen(),
    );
  }
}

class ButtonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MAIN MENU',
          // Set the title color here
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        // Set the app bar color here
        backgroundColor: Color.fromARGB(245, 9, 20, 1),
      ),
      body: Container(
        // Set the background color for the body here
        color: const Color.fromARGB(245, 9, 20, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to GameScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SnakeGame()),
                  );
                },
                child: Text('Play'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Show instructions as a pop-up notification
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Instructions'),
                        content: Text('Swipe Gestures: \n  ▢ Swipe Up: Move the snake upwards. \n  ▢ Swipe Down: Move the snake downwards.\n  ▢ Swipe Left: Move the snake to the left. \n  ▢ Swipe Right: Move the snake to the right. \n\nGameplay: \n  ▢ The snake will start moving automatically in a certain direction. \n  ▢ Your goal is to guide the snake to eat the food(apples) that appears on the board. \n  ▢ Each time the snake eats food(apples), your score will increase by 1 point. \n  ▢ Avoid letting the snake collide with itself, as this will end the game. \n\nWinning the Game: \n▢  Reach a score of 10 to win the game. \n▢  Once you reach the target score, a congratulatory message will appear, indicating that youve won.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Dismiss the dialog
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Instructions'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Show confirmation dialog before quitting
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Quit?'),
                        content: Text('Do you really want to quit?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Dismiss the dialog
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // If user confirms, quit the application
                              SystemNavigator.pop();
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Quit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
