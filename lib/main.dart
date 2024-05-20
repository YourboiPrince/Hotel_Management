import 'package:flutter/material.dart'; // Import Flutter material library
import 'package:hotel/presentation/authentication/screens/signUp_screen.dart'; // Import sign up screen
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core library
import 'package:hotel/presentation/home/bookings_screen.dart';
import 'package:hotel/presentation/home/checkout_screen.dart' as CheckoutScreen;
import 'package:hotel/presentation/home/home_screen.dart'; // Import home screen
import 'package:hotel/providers/admin_provider.dart';
import 'package:hotel/providers/hotel_provider.dart';
import 'core/theme/theme.dart'; // Import theme
import 'firebase_options.dart'; // Import Firebase options
import 'package:provider/provider.dart'; // Import Provider package
import 'package:hotel/providers/auth_provider.dart'; // Import authentication provider
import 'package:hotel/presentation/authentication/screens/login_screen.dart'; // Import login screen
import 'package:hotel/presentation/authentication/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'presentation/dashboard/add_hotels_screen.dart';
import 'presentation/home/admin_screen.dart';
import 'providers/bottom_navigation_provider.dart';
// import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase

  // Initialize Firestore
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

// var dotenv;

// MpesaFlutterPlugin.setConsumerKey(dotenv.env['MPESA_CONSUMER_KEY'] ?? '');
//   MpesaFlutterPlugin.setConsumerSecret(
//       dotenv.env['MPESA_CONSUMER_SECRET'] ?? '');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(
          create: (context) => AdminProvider(),
        ),
        ChangeNotifierProvider(create: (_) => HotelProvider()),
      ],

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
        '/': (context) => HotelScreen(), // This is the screen with the container cards
        '/home': (context) => MyHomePage(title: 'Hotel Page'), // Home screen
        '/signUp': (context) => const SignUpScreen(), // Sign up screen
        '/login': (context) => const LoginScreen(), // Login screen
        '/profile': (context) => const ProfileScreen(),
        '/admin': (context) => AdminScreen(),
        '/addHotels': (context) => const AddHotelScreen(), // Profile screen
        '/bookings': (context) => const BookingsScreen(), // Bookings screen
        '/checkout': (context) => const CheckoutScreen.CheckoutScreen(bookedRooms: []),
      },
    );
  }
}

class HotelScreen extends StatelessWidget {
  final List<String> descriptions = [
    'DUBAI',
    'RWANDA',
    'KENYA',
    'SINGAPORE',
  ];

  final List<String> imagePaths = [
    'assets/images/image.jpg',
    'assets/images/Frame.jpg',
    'assets/images/Frame.jpg',
    'assets/images/image.jpg',
  ];

  HotelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIXXLVE 6-HOTEL'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart), // Cart icon
            onPressed: () {
              // Navigate to checkout screen
              Navigator.pushNamed(context, '/checkout');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Your existing content here...
            Container(
              width: double.infinity,
              height: 200, // Adjust the height as needed
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/hotel_image.jpg'), // Path to your image file
                  fit: BoxFit.fill, // Ensure the image fills the container without distorting its aspect ratio
                ),
              ),
            ),
            const SizedBox(height: 20), // Add some space between the image and the bottom navigation bar
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Popular Places',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20), // Add some space between the title and the cards
            Wrap(
              spacing: 20, // Spacing between the cards
              runSpacing: 20, // Spacing between the rows of cards
              alignment: WrapAlignment.start,
              children: List.generate(
                4,
                (index) => SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4, // Adjust the width according to your design
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset(
                          imagePaths[index],
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(descriptions[index]),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/bookings'); // Navigate to the bookings screen
                          },
                          child: Text('BOOK NOW'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
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
      persistentFooterButtons: [
        Container(
          width: double.infinity, // Width takes up the entire screen width
          height: 50, // Adjust the height as needed
          color: Colors.grey[200], // Background color of the footer

          // Content of the footer
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust as needed
            children: [
              // Add your social icons here
              IconButton(
                icon: const Icon(Icons.facebook), // Example Facebook icon
                onPressed: () {
                  // Implement action for Facebook
                },
              ),
            ],
          ),
        ),
      ],
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
          const Text('Description'), // Add your description here
          const SizedBox(height: 8),
          const Text('Price'), // Add your price here
        ],
      ),
    );
  }
}
