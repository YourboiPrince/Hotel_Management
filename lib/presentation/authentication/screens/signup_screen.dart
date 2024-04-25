import 'package:flutter/material.dart';
import 'package:hotel/presentation/authentication/screens/login_screen.dart'; // Import login screen
import 'package:hotel/presentation/authentication/widgets/logo.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Container(
          width: 450,
          decoration: const BoxDecoration(
            color: Colors.purple, // Set the background color to purple
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const LogoWidget(),
                TextFormField(
                  controller: _displayNameController,
                  decoration: const InputDecoration(
                    labelText: 'displayName',
                  ),
                ),
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
                    String displayName = _displayNameController.text.trim();
                    // Pass the current context to the AuthProvider
                    await context
                       .read<AuthProvider>()
                       .createUserWithEmailAndPassword(
                            context, email, password, displayName);
                    // Check if the user is created successfully
                    if (context.read<AuthProvider>().user!= null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()));
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                //add a button to navigate to the login screen
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}