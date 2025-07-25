import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 80),
            Text("Lead Submitted!", style: TextStyle(fontSize: 24)),
            TextButton(
              child: Text("Go Home"),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => WelcomeScreen()),
                      (route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
