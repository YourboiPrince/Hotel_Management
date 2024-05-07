import 'package:flutter/material.dart';
import 'package:hotel/presentation/home/home_screen.dart';
import 'package:hotel/presentation/authentication/screens/profile_screen.dart'; // Import login screen
import 'package:hotel/presentation/search/search_screen.dart';
import 'package:hotel/providers/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/hotel_provider.dart';
import 'package:hotel/presentation/dashboard/add_hotels_screen.dart'; // Import login screen

class BottomBar extends StatelessWidget {
  BottomBar({
    super.key,
  });
  final List<Widget> currentTab = [
    MyHomePage(title: 'Hotel Page'),
    const SearchScreen(),
    const ProfileScreen(),
    const AddHotelScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HotelProvider()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarProvider()),
      ],
      child: Consumer<BottomNavigationBarProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: currentTab[provider.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: provider.currentIndex,
              onTap: (index) {
                provider.currentIndex = index;
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}