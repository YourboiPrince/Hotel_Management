import 'package:flutter/material.dart'; // Import Flutter material library
import 'package:hotel/presentation/authentication/screens/signUp_screen.dart'; // Import sign up screen
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core library
import 'package:hotel/presentation/home/home_screen.dart'; // Import home screen
import 'core/theme/theme.dart'; // Import theme
import 'firebase_options.dart'; // Import Firebase options
import 'package:provider/provider.dart'; // Import Provider package
import 'package:hotel/providers/auth_provider.dart'; // Import authentication provider
import 'package:hotel/presentation/authentication/screens/login_screen.dart'; // Import login screen
import 'package:hotel/presentation/authentication/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase

  // Initialize Firestore
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(), // Provide authentication provider
      child: const Hotel(),
    ),
  );
}

class Hotel extends StatelessWidget {
  const Hotel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      title: 'Hotel Card', // App title
      theme: AppTheme.theme, // Set app theme
      initialRoute: '/', // Initial route
      routes: {
        '/': (context) => const HotelScreen(), // This is the screen with the container cards
        '/home': (context) => const MyHomePage(title: 'Hotel Page'), // Home screen
        '/signUp': (context) => const SignUpScreen(), // Sign up screen
        '/login': (context) => const LoginScreen(), // Login screen
        '/profile': (context) => const ProfileScreen(), // Profile screen
      },
    );
  }
}

class HotelScreen extends StatelessWidget {
  const HotelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Management'), // Set app bar title
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            6,
            (index) => ContainerCard(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login), // Login icon
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add), // Sign up icon
            label: 'Sign Up',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/login'); // Navigate to login screen
          } else if (index == 1) {
            Navigator.pushNamed(context, '/signUp'); // Navigate to sign up screen
          }
        },
      ),
    );
  }
}

class ContainerCard extends StatelessWidget {
  const ContainerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/room2.png', // Path to your image file
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text('Description'), // Add your description here
          const SizedBox(height: 8),
          Text('Price'), // Add your price here
        ],
      ),
    );
  }
}
