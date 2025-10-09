import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import '../../../core/color_resources.dart';
import '../bloc/job/job_bloc.dart';
import '../bloc/job/job_event.dart';
import '../bloc/job/job_state.dart';
import '../models/job_model.dart';
import '../repositories/job_repositories.dart';
import '../widgets/job_section/job_bottom_bar.dart';
import '../widgets/job_section/job_tab_content.dart';

class JobDetailScreen extends StatefulWidget {
  final String jobId;

  const JobDetailScreen({super.key, required this.jobId});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late JobRepositories _repository;

  bool _isBookmarked = false;
  bool _isApplying = false;
  bool _isBookmarkLoading = false; // เพิ่ม loading state สำหรับ bookmark

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _repository = JobRepositories();

    // โหลด bloc และเช็ค bookmark status
    context.read<JobBloc>().add(LoadJobDetail(widget.jobId));
    _checkBookmarkStatus();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ✅ เช็คว่างานนี้ถูก bookmark หรือไม่
  Future<void> _checkBookmarkStatus() async {
    try {
      final isBookmarked = await _repository.isJobBookmarked(widget.jobId);
      if (mounted) {
        setState(() {
          _isBookmarked = isBookmarked;
        });
      }
    } catch (e) {
      print('Error checking bookmark status: $e');
    }
  }

  Future<void> _applyJob() async {
    setState(() {
      _isApplying = true;
    });

    try {
      // Simulate API call for job application
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('สมัครงานเรียบร้อยแล้ว!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back to home after successful application
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาด: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isApplying = false;
        });
      }
    }
  }

  // ✅ แก้ไข: เชื่อมต่อกับ API จริง
  Future<void> _toggleBookmark() async {
    // ป้องกันการกดซ้ำ
    if (_isBookmarkLoading) return;

    setState(() {
      _isBookmarkLoading = true;
    });

    try {
      if (_isBookmarked) {
        // ลบ bookmark
        await _repository.removeBookmark(widget.jobId);

        if (mounted) {
          setState(() {
            _isBookmarked = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('ยกเลิกการบันทึกแล้ว', style: fontBody.copyWith()),
              backgroundColor: ColorResources.colorPorpoise,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      } else {
        // เพิ่ม bookmark
        await _repository.bookmarkJob(widget.jobId);

        if (mounted) {
          setState(() {
            _isBookmarked = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('บันทึกงานแล้ว', style: fontBody.copyWith()),
              backgroundColor: ColorResources.primaryColor,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      }
    } catch (e) {
      print('Error toggling bookmark: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาด: ${e.toString()}', style: fontBody),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isBookmarkLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        String jobTitle = '';
        String companyName = '';
        double matchPercentage = 0;

        if (state is JobDetailLoaded) {
          jobTitle = state.job.title;
          companyName = state.job.company.name;
          matchPercentage = state.job.aiSkillMatch.score * 10;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: JobDetailAppBar(
            jobTitle: jobTitle,
            companyName: companyName,
            matchPercentage: matchPercentage,
          ),
          body: _buildBody(state),
          bottomNavigationBar: JobBottomBar(
            isBookmarked: _isBookmarked,
            isLoading: _isApplying || _isBookmarkLoading, // รวม loading state
            onBookmarkPressed: _toggleBookmark,
            onApplyPressed: _applyJob,
          ),
        );
      },
    );
  }

  Widget _buildBody(JobState state) {
    if (state is JobLoading) {
      return const JobDetailLoading();
    } else if (state is JobDetailLoaded) {
      final job = state.job;
      return Column(
        children: [
          JobTabBar(tabController: _tabController),
          Expanded(
            child: JobTabContent(
              tabController: _tabController,
              job: job,
            ),
          ),
        ],
      );
    } else if (state is JobError) {
      return JobDetailError(
        message: state.message,
        onRetry: () => context.read<JobBloc>().add(LoadJobDetail(widget.jobId)),
      );
    }
    return const SizedBox.shrink();
  }
}

class JobDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String jobTitle;
  final String companyName;
  final double matchPercentage;

  const JobDetailAppBar({
    super.key,
    required this.jobTitle,
    required this.companyName,
    required this.matchPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorResources.colorCharcoal.withOpacity(0.08),
            offset: const Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorResources.buttonColor),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    jobTitle,
                    style: fontBodyStrong.copyWith(
                        color: ColorResources.colorCharcoal),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    companyName,
                    style: fontSmall.copyWith(
                        color: ColorResources.colorPorpoise),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                gradient: ColorResources.gd3Gradient.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: GradientBoxBorder(
                  gradient: ColorResources.gd3Gradient,
                  width: 1,
                ),
              ),
              child: Row(
                spacing: 2,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.diamond,
                    size: 12,
                    color: Color(0xFF596DF8),
                  ),
                  Text(
                    '$matchPercentage%',
                    style: fontSmallStrong.copyWith(color: Color(0xFF596DF8)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class JobTabBar extends StatelessWidget {
  final TabController tabController;

  const JobTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        labelColor: ColorResources.primaryColor,
        unselectedLabelColor: ColorResources.colorPorpoise,
        indicatorColor: ColorResources.primaryColor,
        dividerColor: Colors.transparent,
        indicatorWeight: 2,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: const [
          Tab(child: Text('ภาพรวม', style: fontBody)),
          Tab(child: Text('หน้าที่งาน', style: fontBody)),
          Tab(child: Text('คุณสมบัติ', style: fontBody)),
          Tab(child: Text('ไลฟ์สไตล์', style: fontBody)),
          Tab(child: Text('ติดต่อ', style: fontBody)),
        ],
      ),
    );
  }
}

class JobTabContent extends StatelessWidget {
  final TabController tabController;
  final JobModel job;

  const JobTabContent({
    super.key,
    required this.tabController,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        OverviewTab(job: job),
        ResponsibilitiesTab(
          job: job,
        ),
        QualificationsTab(
          job: job,
        ),
        LifestyleTab(),
        ContactTab(
          job: job,
        ),
      ],
    );
  }
}

class JobDetailLoading extends StatelessWidget {
  const JobDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: ColorResources.primaryColor,
      ),
    );
  }
}

class JobDetailError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const JobDetailError({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
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
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorResources.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('ลองใหม่'),
          ),
        ],
      ),
    );
  }
}