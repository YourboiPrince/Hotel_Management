import 'package:flutter/material.dart';
import 'package:hotel/presentation/authentication/widgets/logo.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'package:hotel/presentation/authentication/screens/profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<LoginScreen> {
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
        title: const Text('Login'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Container(
          width: 450, // Setting width to 450px
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.purple[50], // Light purple background color
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const LogoWidget(),
              const SizedBox(height: 16), // Add space between the logo and form fields
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.mail, color: Colors.purple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.purple),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.purple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.purple),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16), // Add space between the password field and button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () async {
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();
                  await context.read<AuthProvider>().signInWithEmailAndPassword(context, email, password);
                  if (context.read<AuthProvider>().user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 16), // Add space between the login button and admin button
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin');
                },
                child: const Text('Login as admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
