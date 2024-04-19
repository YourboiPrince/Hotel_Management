import 'package:flutter/material.dart'; // Import Flutter material library

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title), // Set app bar title
        centerTitle: true, // Center the title
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/logo.png', // Replace with your image path
              fit: BoxFit.cover, // Fit the image within the container
            ),
            const SizedBox(height: 16), // Added some spacing
            const Text('Hotel Booking Card'), // Display text
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signUp'); // Navigate to sign up screen
              },
              child: const Text('Sign up'), // Sign up button
            ),
          ],
        ),
      ),
    );
  }
}
