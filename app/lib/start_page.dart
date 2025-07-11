import 'package:app/game_page.dart'; // Assuming MyGamePage is defined here
import 'package:flutter/material.dart';

class MyStartPage extends StatefulWidget {
  const MyStartPage({super.key});

  @override
  State<StatefulWidget> createState() => _MyStartPageState();
}

class _MyStartPageState extends State<MyStartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Added Scaffold for proper material design structure
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Tic Tac Toe"),
      ),
      body: Center(
        // Center the content within the Scaffold's body
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            ElevatedButton(
              onPressed: () {
                // Corrected: Use Navigator to push the new screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyGamePage(title: "Tic Tac Toe", isTwoPlayer: false),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Text(
                "1 Player",
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Corrected: Use Navigator to push the new screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyGamePage(title: "Tic Tac Toe", isTwoPlayer: true),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Text(
                "2 Player",
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
