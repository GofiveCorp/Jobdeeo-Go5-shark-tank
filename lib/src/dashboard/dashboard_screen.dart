import 'package:flutter/material.dart';
import 'package:jobdeeo/src/features/job_board/screen/bookmark_screen.dart';
import 'package:jobdeeo/src/features/job_board/screen/job_board_screen.dart';
import 'package:jobdeeo/src/core/base/image_resource.dart';
import '../core/services/preferences_service.dart';
import '../features/community/community_screen.dart';
import '../features/learn/learn_scren.dart';
import '../features/matching/matching_screen.dart';
import '../features/profile/profile_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatefulWidget {
  final int initialIndex;

  const DashboardScreen({super.key, this.initialIndex = 0});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  bool _isQuestionnaireCompleted = false;


  @override
  void initState() {
    super.initState();
    _checkQuestionnaireStatus();
    _currentIndex = widget.initialIndex;
  }

  Future<void> _checkQuestionnaireStatus() async {
    final isCompleted = await PreferencesService.isQuestionnaireCompleted();
    setState(() {
      _isQuestionnaireCompleted = isCompleted;
    });
  }

  List<Widget> get _screens => [
        JobBoardScreen(),
        if (_isQuestionnaireCompleted) BookmarkScreen(),
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
    if (_isQuestionnaireCompleted)
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          ImageResource.bookmarkUnselected
          ,
          width: 28,
          height: 28,
        ),
        activeIcon: SvgPicture.asset(
          ImageResource.bookmarkselected,
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
