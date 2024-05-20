import 'package:flutter/material.dart';
import 'package:hotel/presentation/authentication/widgets/logo.dart';
import 'package:hotel/presentation/home/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _phoneNumber = TextEditingController();
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
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 450, // Set the width to 450px
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const LogoWidget(),
                  TextFormField(
                    controller: _displayNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      labelText: 'Full Name',
                      prefixIcon: const Icon(Icons.person,
                          color: Colors.purple, size: 24),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.purple),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.mail,
                          color: Colors.purple, size: 24),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.purple),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneNumber,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Number';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      labelText: 'Phone Number',
                      prefixIcon: const Icon(Icons.phone,
                          color: Colors.purple, size: 24),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.purple),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // Add more complex validation if needed
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.visibility_off,
                          color: Colors.purple, size: 24),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.purple),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      } else {
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        String displayName = _displayNameController.text.trim();
                        int phoneNumber = int.parse(_phoneNumber.text.trim());
                        // Pass the current context to the AuthProvider
                        await context
                            .read<AuthProvider>()
                            .createUserWithEmailAndPassword(context, email,
                                password, displayName, phoneNumber);
                        // Check if the user is created successfully
                        if (context.read<AuthProvider>().user != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomBar()));
                        }
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                  // Add a button to navigate to the login screen
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
      ),
    );
  }
}
