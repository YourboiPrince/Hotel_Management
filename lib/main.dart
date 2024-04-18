import 'package:flutter/material.dart';
import 'package:hotel/presentation/authentication/screens/signUp_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotel/presentation/home/home_screen.dart';
import 'core/theme/theme.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'package:hotel/presentation/authentication/screens/login_screen.dart';
import 'package:hotel/presentation/authentication/screens/profile_screen.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const Hotel(),
    ),
  );
}

class Hotel extends StatelessWidget {
  const Hotel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Card',
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HotelScreen(), // This is the screen with the container cards
        '/home': (context) => const MyHomePage(title: 'Hotel Page'),
        '/signUp': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile': (context) => const ProfileScreen(),
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
        title: const Text('Hotel Management'),
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
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Sign Up',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/login');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/signUp');
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
