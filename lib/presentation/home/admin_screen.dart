import 'package:flutter/material.dart';
import 'package:hotel/presentation/authentication/widgets/logo.dart';
import 'package:provider/provider.dart';

import '../../providers/admin_provider.dart';

class AdminScreen extends StatelessWidget {
  // ignore: use_super_parameters
  AdminScreen({Key? key}) : super(key: key); // Fix the constructor syntax

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
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
                  // SignInWithEmailAndPassword should return a Future
                  await context
                      .read<AdminProvider>()
                      .signInWithEmailAndPassword(context, email, password); // Remove context parameter
                  // Navigate only if the sign-in is successful
                  Navigator.pushNamed(context, '/addHotels');
                } catch (error) {
                  // Handle sign-in errors here
                  print('Sign-in error: $error');
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
