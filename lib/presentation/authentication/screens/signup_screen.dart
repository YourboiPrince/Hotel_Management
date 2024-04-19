import 'package:flutter/material.dart'; // Import Flutter material library
import 'package:hotel/presentation/authentication/screens/login_screen.dart'; // Import login screen
import 'package:hotel/presentation/authentication/widgets/logo.dart'; // Import logo widget
import 'package:hotel/providers/auth_provider.dart' as hotel_provider; // Import authentication provider as hotel_provider
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth library

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        title: const Text('Sign Up'), // Set app bar title
      ),
      body: Container(
        color: Colors.purple, // Purple background color
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 450, // Adjusted width to 450 pixels
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoWidget(), // Display logo widget
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16), // SizedBox for spacing
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true, // Hide password text
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String email = _emailController.text.trim(); // Get email input
                      String password = _passwordController.text.trim(); // Get password input

                      try {
                        // Create user with FirebaseAuth
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        // Optionally, you can do something after successful sign-up
                        // For example, update user data in your AuthProvider
                        hotel_provider.AuthProvider()
                            // ignore: use_build_context_synchronously
                            .createUserWithEmailAndPassword(context, email, password);
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      } catch (e) {
                        // Handle sign-up failure
                        print('Error signing up: $e');
                        // Optionally, display an error message to the user
                      }
                    },
                    child: const Text('Sign Up'), // Sign up button
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
