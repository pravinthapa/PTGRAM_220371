import 'package:flutter/material.dart';
import 'package:prabin/screens/register_screen.dart';
// Import your SignupPage here
// Example: import 'package:your_project_name/signup_page.dart';

class OnboardingScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/vectors/onbaording.png', // Add your image in the assets folder and update this path
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to PTgram',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen2()),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/vectors/onbaording.png', // Add your second image in the assets folder
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Discover Amazing Features!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to your signup page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RegisterPage()), // Replace with your actual SignupPage class
                );
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
