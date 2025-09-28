import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';

import '../bloc/matching_bloc.dart';
import '../bloc/matching_event.dart';
import '../bloc/matching_state.dart';
import '../widgets/swipe_job_card.dart';

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({super.key});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _swipeAnimationController;

  Offset _dragPosition = Offset.zero;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _swipeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    context.read<MatchingBloc>().add(LoadMatchingJobs());
  }

  @override
  void dispose() {
    _pageController.dispose();
    _swipeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.backgroundColor,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/common/matching_background_with_card.png',
              fit: BoxFit.cover,
            ),
          ),
          // Main content
          Column(
            children: [
              Expanded(
                child: BlocBuilder<MatchingBloc, MatchingState>(
                  builder: (context, state) {
                    return _buildBody(state);
                  },
                ),
              ),
              // Bottom bar as part of body
              _buildBottomBar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(MatchingState state) {
    if (state is MatchingLoading) {
      return Column(
        children: [
          SizedBox(height: 80),
          Container(
              height: 520,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFF1F7F7), width: 4)
              ),
              child: Center(child: CircularProgressIndicator()),),
        ],
      );
    } else if (state is MatchingError) {
      return _buildErrorState(state.message);
    } else if (state is MatchingEmpty) {
      return _buildEmptyState();
    } else if (state is MatchingLoaded) {
      return _buildLoadedState(state);
    }
    return const SizedBox.shrink();
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: fontBody.copyWith(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<MatchingBloc>().add(LoadMatchingJobs());
            },
            child: const Text('ลองใหม่'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outline,
            size: 64,
            color: ColorResources.colorPorpoise,
          ),
          const SizedBox(height: 16),
          Text(
            'ไม่มีงานที่เหมาะสมแล้ว',
            style: fontBodyStrong.copyWith(
              color: ColorResources.colorCharcoal,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ลองปรับการตั้งค่าการค้นหาของคุณ',
            style: fontBody.copyWith(
              color: ColorResources.colorPorpoise,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<MatchingBloc>().add(ResetCards());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorResources.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text('เริ่มใหม่'),
          ),
        ],
      ),
    );
  }

  // Widget _buildLoadedState(MatchingLoaded state) {
  //   return Stack(
  //     children: [
  //       // Main card stack
  //       Positioned.fill(
  //         child: PageView.builder(
  //           controller: _pageController,
  //           itemCount: state.jobs.length,
  //           onPageChanged: (index) {
  //             // Handle page change if needed
  //           },
  //           itemBuilder: (context, index) {
  //             if (index == state.currentJobIndex) {
  //               return SwipeJobCard(
  //                 job: state.currentJob,
  //                 currentTabIndex: state.currentTabIndex,
  //                 onTabChanged: (tabIndex) {
  //                   context.read<MatchingBloc>().add(ChangeTab(tabIndex));
  //                 },
  //               );
  //             }
  //             return const SizedBox.shrink();
  //           },
  //         ),
  //       ),
  //
  //       // Card navigation indicators
  //       if (state.jobs.length > 1)
  //         Positioned(
  //           top: 16,
  //           left: 0,
  //           right: 0,
  //           child: _buildCardIndicators(state),
  //         ),
  //     ],
  //   );
  // }

  Widget _buildLoadedState(MatchingLoaded state) {
    return Stack(
      children: [
        // Show next card behind
        if (state.currentJobIndex + 1 < state.jobs.length)
          _buildSwipeableCard(state, state.currentJobIndex + 1),

        // Show current card on top
        _buildSwipeableCard(state, state.currentJobIndex),
      ],
    );
  }

  Widget _buildCardIndicators(MatchingLoaded state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: List.generate(state.jobs.length, (index) {
          final isActive = index == state.currentJobIndex;
          return Expanded(
            child: Container(
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isActive
                    ? ColorResources.primaryColor
                    : ColorResources.colorCloud,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNavigationHint() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.touch_app,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              'แตะด้านข้างเพื่อเปลี่ยนแท็บ',
              style: fontSmall.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BlocBuilder<MatchingBloc, MatchingState>(
      builder: (context, state) {
        if (state is! MatchingLoaded) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.only(right: 32, left: 32, top: 16, bottom: 32),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // retry button
              _buildActionButton(
                icon: Icons.refresh_rounded,
                color: Colors.grey,
                onTap: () {
                  context.read<MatchingBloc>().add(
                    SwipeLeft(state.currentJob.id),
                  );
                },
              ),

              // Pass button
              _buildActionButton(
                icon: Icons.close_rounded,
                color: Colors.red,
                onTap: () {
                  context.read<MatchingBloc>().add(
                    SwipeLeft(state.currentJob.id),
                  );
                },
              ),

              // Bookmark button
              _buildActionButton(
                icon: Icons.bookmark,
                color: ColorResources.primaryColor,
                onTap: () {
                  // Handle bookmark
                },
              ),

              // Like button
              _buildActionButton(
                icon: Icons.send_rounded,
                color: Colors.white,
                gradientBackground: ColorResources.linearGradient,
                onTap: () {
                  context.read<MatchingBloc>().add(
                    SwipeRight(state.currentJob.id),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    LinearGradient? gradientBackground,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: gradientBackground,
          color: gradientBackground == null ? Colors.white : null,
        ),
        child: Icon(
          icon,
          color: color,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildSwipeableCard(MatchingLoaded state, int cardIndex) {
    final isTopCard = cardIndex == state.currentJobIndex;
    final job = state.jobs[cardIndex];

    return AnimatedBuilder(
      animation: _swipeAnimationController,
      builder: (context, child) {
        return Transform.translate(
          offset: isTopCard ? _dragPosition : Offset.zero,
          child: Transform.rotate(
            angle: isTopCard ? _dragPosition.dx / 1000 : 0,
            child: GestureDetector(
              onPanStart: isTopCard ? _onPanStart : null,
              onPanUpdate: isTopCard ? _onPanUpdate : null,
              onPanEnd: isTopCard ? _onPanEnd : null,
              child: Stack(
                children: [
                  SwipeJobCard(
                    job: job,
                    currentTabIndex: isTopCard ? state.currentTabIndex : 0,
                    onTabChanged: isTopCard ? (tabIndex) {
                      context.read<MatchingBloc>().add(ChangeTab(tabIndex));
                    } : (tabIndex) {},
                  ),
                  if (isTopCard && _isDragging) _buildSwipeOverlay(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * 0.3;

    if (_dragPosition.dx > threshold) {
      _swipeRight();
    } else if (_dragPosition.dx < -threshold) {
      _swipeLeft();
    } else {
      _resetCard();
    }
  }

  void _swipeRight() {
    // Animate card out to the right
    _animateCardOut(isRight: true);
  }

  void _swipeLeft() {
    // Animate card out to the left
    _animateCardOut(isRight: false);
  }

  void _resetCard() {
    setState(() {
      _dragPosition = Offset.zero;
      _isDragging = false;
    });
  }

  Widget _buildSwipeOverlay() {
    final isSwipingRight = _dragPosition.dx > 50;
    final isSwipingLeft = _dragPosition.dx < -50;

    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSwipingLeft
              ? Colors.red.withOpacity(0.3)
              : isSwipingRight
              ? Colors.green.withOpacity(0.3)
              : Colors.transparent,
        ),
        child: Stack(
          children: [
            if (isSwipingLeft)
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 30),
                ),
              ),
            if (isSwipingRight)
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 30),
                ),
              ),
          ],
        ),
      ),
    );
  }
  void _animateCardOut({required bool isRight}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final endPosition = Offset(isRight ? screenWidth : -screenWidth, _dragPosition.dy);

    _swipeAnimationController.forward().then((_) {
      // Reset animation and position
      _swipeAnimationController.reset();
      setState(() {
        _dragPosition = Offset.zero;
        _isDragging = false;
      });

      // Trigger appropriate bloc event
      final currentState = context.read<MatchingBloc>().state;
      if (currentState is MatchingLoaded) {
        if (isRight) {
          context.read<MatchingBloc>().add(SwipeRight(currentState.currentJob.id));
        } else {
          context.read<MatchingBloc>().add(SwipeLeft(currentState.currentJob.id));
        }
      }
    });

    // Animate to end position
    final animation = Tween<Offset>(
      begin: _dragPosition,
      end: endPosition,
    ).animate(CurvedAnimation(
      parent: _swipeAnimationController,
      curve: Curves.easeOut,
    ));

    animation.addListener(() {
      setState(() {
        _dragPosition = animation.value;
      });
    });
  }
}