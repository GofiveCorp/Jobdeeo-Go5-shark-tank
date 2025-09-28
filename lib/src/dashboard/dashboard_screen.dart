import 'package:flutter/material.dart';
import 'package:jobdeeo/src/features/job_board/screen/job_board_screen.dart';
import 'package:jobdeeo/src/features/questionnaire/screen/questionaire_screen.dart';
import 'package:jobdeeo/src/core/base/image_resource.dart';
import '../features/community/community_screen.dart';
import '../features/home/home_screen.dart';
import '../features/learn/learn_scren.dart';
import '../features/matching/screen/matching_screen.dart';
import '../features/profile/profile_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    JobBoardScreen(),
    CommunityScreen(),
    MatchingScreen(),
    LearnScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar:
      BottomNavigationBar(
  currentIndex: _currentIndex,
  type: BottomNavigationBarType.fixed,
  showSelectedLabels: false,
  showUnselectedLabels: false,
  onTap: (index) {
    setState(() => _currentIndex = index);
  },
  items: [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ImageResource.homeUnselected,
        width: 28,
        height: 28,
      ),
      activeIcon: SvgPicture.asset(
        ImageResource.homeSelected,
        width: 28,
        height: 28,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ImageResource.newFeedUnselected,
        width: 28,
        height: 28,
      ),
      activeIcon: SvgPicture.asset(
        ImageResource.newFeedSelected,
        width: 28,
        height: 28,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ImageResource.swipeUnselected,
        width: 28,
        height: 28,
      ),
      activeIcon: SvgPicture.asset(
        ImageResource.swipeSelected,
        width: 28,
        height: 28,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ImageResource.learnUnselected,
        width: 28,
        height: 28,
      ),
      activeIcon: SvgPicture.asset(
        ImageResource.learnSelected,
        width: 28,
        height: 28,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        ImageResource.profileUnselected,
        width: 28,
        height: 28,
      ),
      activeIcon: SvgPicture.asset(
        ImageResource.profileSelected,
        width: 28,
        height: 28,
      ),
      label: '',
    ),
  ],
)

    );
  }
}
