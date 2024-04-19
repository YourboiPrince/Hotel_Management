import 'package:flutter/material.dart'; // Import Flutter material library
import 'package:hotel/presentation/authentication/widgets/logo.dart'; // Import logo widget
import 'package:provider/provider.dart'; // Import Provider package
import 'package:hotel/providers/auth_provider.dart'; // Import authentication provider
import 'package:hotel/presentation/authentication/screens/profile_screen.dart'; // Import profile screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController(); // Controller for email field
  final TextEditingController _passwordController = TextEditingController(); // Controller for password field

  @override
  void dispose() {
    _emailController.dispose(); // Dispose email controller
    _passwordController.dispose(); // Dispose password controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'), // Set app bar title
      ),
      body: Center(
        child: Container(
          width: 450, // Setting width to 450px
          decoration: BoxDecoration(
            color: Colors.purple, // Purple background color
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LogoWidget(), // Display logo widget
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email', // Email text field
                  ),
                ),
                const SizedBox(height: 16), // SizedBox for spacing
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password', // Password text field
                  ),
                  obscureText: true, // Hide password text
                ),
                ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text.trim(); // Get email input
                    String password = _passwordController.text.trim(); // Get password input
                    // Pass the current context to the AuthProvider
                    await context
                        .read<AuthProvider>()
                        .signInWithEmailAndPassword(context, email, password);
                    // Check if the user is signed in successfully
                    if (context.read<AuthProvider>().user != null) {
                      // Navigate to the profile screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text('Login'), // Login button
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
