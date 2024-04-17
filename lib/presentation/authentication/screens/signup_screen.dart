import 'package:flutter/material.dart';
import 'package:hotel/presentation/authentication/screens/login_screen.dart';
import 'package:hotel/presentation/authentication/widgets/logo.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const LogoWidget(),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  // Optionally, you can do something after successful sign-up
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                } catch (e) {
                  // Handle sign-up failure
                  print('Error signing up: $e');
                  // Optionally, display an error message to the user
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
