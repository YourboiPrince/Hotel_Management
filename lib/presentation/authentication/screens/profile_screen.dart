import 'package:flutter/material.dart'; // Import Flutter material library
import 'package:provider/provider.dart'; // Import Provider package
import 'package:hotel/providers/auth_provider.dart'; // Import authentication provider
import 'package:hotel/domain/models/user_model.dart'; // Import user model

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true); // Get authentication provider
    final UserModel? user = authProvider.user; // Get user from authentication provider
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'), // Set app bar title
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${user?.email ?? 'Guest'}', // Display user's email or 'Guest'
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the main screen
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Logout'), // Logout button
            ),
          ],
        ),
      ),
    );
  }
}
