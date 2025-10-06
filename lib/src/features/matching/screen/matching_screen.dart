import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';

import '../bloc/matching_bloc.dart';
import '../bloc/matching_event.dart';
import '../bloc/matching_state.dart';
import '../widgets/swipe_job_card.dart';
import 'matching_success_screen.dart';

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
      body: BlocListener<MatchingBloc, MatchingState>(
        listener: (context, state) {
          // Navigate to success screen when MatchingSuccess state is emitted
          if (state is MatchingSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MatchingSuccessScreen(job: state.job),
              ),
            );
          }
        },
        child: Stack(
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
                // Bottom bar
                _buildBottomBar(),
              ],
            ),
          ],
        ),
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
              border: Border.all(color: Color(0xFFF1F7F7), width: 4),
            ),
            child: Center(child: CircularProgressIndicator()),
          ),
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
    // Auto-reload เมื่อเจอ empty state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MatchingBloc>().add(ResetCards());
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: ColorResources.primaryColor,
          ),
          const SizedBox(height: 24),
          Text(
            'กำลังโหลดงานใหม่...',
            style: fontBody.copyWith(color: ColorResources.colorPorpoise),
          ),
        ],
      ),
    );
  }

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
              // Retry button
              _buildActionButton(
                icon: Icons.refresh_rounded,
                color: Colors.grey,
                onTap: () {
                  context.read<MatchingBloc>().add(ResetCards());
                },
              ),

              // Pass button (กากบาท - swipe left)
              _buildActionButton(
                icon: Icons.close_rounded,
                color: Colors.red,
                onTap: () {
                  _swipeLeft(); // เรียก animation แทนการส่ง event โดยตรง
                },
              ),

              // Bookmark button (บันทึก - swipe down)
              _buildActionButton(
                icon: Icons.bookmark,
                color: ColorResources.primaryColor,
                onTap: () {
                  _swipeDown(); // animation ลงข้างล่าง
                },
              ),

              // Like button (ส่ง - swipe right)
              _buildActionButton(
                icon: Icons.send_rounded,
                color: Colors.white,
                gradientBackground: ColorResources.linearGradient,
                onTap: () {
                  _swipeRight(); // เรียก animation แทนการส่ง event โดยตรง
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
        width: 48,
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
                    onTabChanged: isTopCard
                        ? (tabIndex) {
                      context.read<MatchingBloc>().add(ChangeTab(tabIndex));
                    }
                        : (tabIndex) {},
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
    _animateCardOut(direction: SwipeDirection.right);
  }

  void _swipeLeft() {
    _animateCardOut(direction: SwipeDirection.left);
  }

  void _swipeDown() {
    _animateCardOut(direction: SwipeDirection.down);
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
              left: 20,
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
    );
  }

  void _animateCardOut({required SwipeDirection direction}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Offset endPosition;

    switch (direction) {
      case SwipeDirection.left:
        endPosition = Offset(-screenWidth, _dragPosition.dy);
        break;
      case SwipeDirection.right:
        endPosition = Offset(screenWidth, _dragPosition.dy);
        break;
      case SwipeDirection.down:
        endPosition = Offset(_dragPosition.dx, screenHeight);
        break;
    }

    _swipeAnimationController.forward().then((_) {
      _swipeAnimationController.reset();
      setState(() {
        _dragPosition = Offset.zero;
        _isDragging = false;
      });

      // ส่ง event ไปที่ bloc หลังจาก animation เสร็จ
      final currentState = context.read<MatchingBloc>().state;
      if (currentState is MatchingLoaded) {
        switch (direction) {
          case SwipeDirection.right:
            context
                .read<MatchingBloc>()
                .add(SwipeRight(currentState.currentJob.id));
            break;
          case SwipeDirection.left:
            context
                .read<MatchingBloc>()
                .add(SwipeLeft(currentState.currentJob.id));
            break;
          case SwipeDirection.down:
          // ส่ง event สำหรับบันทึก (bookmark)
            context
                .read<MatchingBloc>()
                .add(BookmarkJob(currentState.currentJob.id));
            break;
        }
      }
    });

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

// Enum สำหรับทิศทางการ swipe
enum SwipeDirection {
  left,
  right,
  down,
}