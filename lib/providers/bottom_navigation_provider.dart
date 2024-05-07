import 'package:flutter/material.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

















// import 'package:flutter/material.dart';
// import 'package:hotel/presentation/home/home_screen.dart'; // Import home screen
// import 'package:hotel/presentation/authentication/screens/profile_screen.dart';
// import 'package:provider/provider.dart'; // Import profile screen

// class BottomNavigationProvider extends ChangeNotifier {
//   int _currentIndex = 0;

//   int get currentIndex => _currentIndex;

//   void setCurrentIndex(int index) {
//     _currentIndex = index;
//     notifyListeners();
//   }
// }

// class HomePage extends StatelessWidget {
//   final List<Widget> _screens = [
//     const MyHomePage(title: ''),
//     // const SearchScreen(),
//     const ProfileScreen(),
//   ];

//   HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bottom Navigation Example'),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Consumer<BottomNavigationProvider>(
//         builder: (context, provider, child) {
//           return _screens[provider.currentIndex];
//         },
//       ),
//       bottomNavigationBar: Consumer<BottomNavigationProvider>(
//         builder: (context, provider, child) {
//           return BottomNavigationBar(
//             currentIndex: provider.currentIndex,
//             onTap: (index) {
//               provider.setCurrentIndex(index);
//             },
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'Profile',
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
