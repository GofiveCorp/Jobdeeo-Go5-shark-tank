import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/job/job_bloc.dart';
import '../bloc/job/job_event.dart';
import '../bloc/job/job_state.dart';
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
  bool _isBookmarked = false;
  bool _isApplying = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    context.read<JobBloc>().add(LoadJobDetail(widget.jobId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _applyJob() async {
    setState(() {
      _isApplying = true;
    });

    try {
      // Simulate API call for job application
      await Future.delayed(const Duration(seconds: 2));

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

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isBookmarked ? 'บันทึกงานแล้ว' : 'ยกเลิกการบันทึก'),
        backgroundColor: _isBookmarked ? Colors.green : Colors.grey,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        String jobTitle = '';
        String companyName = '';

        if (state is JobDetailLoaded) {
          jobTitle = state.job.title;
          companyName = state.job.companyName;
        }

        return Scaffold(
          appBar: JobDetailAppBar(
            jobTitle: jobTitle,
            companyName: companyName,
          ),
          body: _buildBody(state),
          bottomNavigationBar: JobBottomBar(
            isBookmarked: _isBookmarked,
            isLoading: _isApplying,
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

  const JobDetailAppBar({
    super.key,
    required this.jobTitle,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.teal),
            onPressed: () {
              Navigator.pop(context, true); // ส่งค่า true เพื่อให้หน้าหลัก refresh
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  jobTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  companyName,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.purple[200]!),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.diamond,
                  size: 16,
                  color: Colors.purple[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '89%',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.purple[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
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
        labelColor: Colors.teal,
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: Colors.teal,
        indicatorWeight: 2,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs: const [
          Tab(text: 'ภาพรวม'),
          Tab(text: 'หน้าที่งาน'),
          Tab(text: 'คุณสมบัติ'),
          Tab(text: 'ไลฟ์สไตล์'),
          Tab(text: 'ติดต่อ'),
        ],
      ),
    );
  }
}

class JobTabContent extends StatelessWidget {
  final TabController tabController;
  final job;

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
        const ResponsibilitiesTab(),
        const QualificationsTab(),
        const LifestyleTab(),
        const ContactTab(),
      ],
    );
  }
}

class JobDetailLoading extends StatelessWidget {
  const JobDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
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
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('ลองใหม่'),
          ),
        ],
      ),
    );
  }
}