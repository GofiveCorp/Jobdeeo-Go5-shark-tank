import 'package:flutter/material.dart';
import '../features/community/community_screen.dart';
import '../features/home/home_screen.dart';
import '../features/learn/learn_scren.dart';
import '../features/matching/matching_screen.dart';
import '../features/profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    CommunityScreen(),
    MatchingScreen(),
    LearnScreen(),
    ProfileScreen(),
  ];

  final List<String> _titles = const [
    "Home",
    "Community",
    "Matching",
    "Learn",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 28,
        selectedItemColor: Colors.purple,   // สีตอนเลือก
        unselectedItemColor: Colors.grey,   // สีตอนยังไม่เลือก
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.saved_search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),



    );
  }
}
