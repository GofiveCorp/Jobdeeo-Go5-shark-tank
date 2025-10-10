import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:jobdeeo/src/core/color_resources.dart';

import '../../../core/base/txt_styles.dart';
import '../../matching/repositories/matching_repositories.dart';
import '../bloc/bookmark/bookmark_bloc.dart';
import '../bloc/bookmark/bookmark_event.dart';
import '../bloc/bookmark/bookmark_state.dart';
import 'job_detail_screen.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // สร้าง BookmarkBloc และ load bookmarked jobs
      create: (context) => BookmarkBloc(repository: MatchingRepository())
        ..add(LoadBookmarkedJobs()),
      child: Scaffold(
        backgroundColor: ColorResources.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('งานของฉัน',
                  style: fontHeader5.copyWith(
                      color: ColorResources.colorCharcoal)),
              centerTitle: true,
            ),
          ),
        ),
        body: Column(
          children: [
            BookmarkTabBar(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  SavedJobsTab(),
                  AppliedJobsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Tab Bar
class BookmarkTabBar extends StatelessWidget {
  final TabController tabController;

  const BookmarkTabBar({
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
        indicatorWeight: 2,
        dividerColor: Colors.transparent,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: EdgeInsets.only(right: 30, left: 0),
        padding: EdgeInsets.symmetric(horizontal: 16),
        tabs: [
          Tab(
            child: BlocBuilder<BookmarkBloc, BookmarkState>(
              builder: (context, state) {
                final count = state is BookmarkLoaded ? state.jobs.length : 0;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('งานที่บันทึก', style: fontBody.copyWith()),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: ColorResources.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$count',
                        style: fontBody.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('งานที่สมัคร', style: fontBody.copyWith()),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: ColorResources.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '0',
                    style: fontBody.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Saved Jobs Tab - ใช้ BlocBuilder แทน mock data
class SavedJobsTab extends StatelessWidget {
  const SavedJobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        if (state is BookmarkLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorResources.primaryColor,
            ),
          );
        }

        if (state is BookmarkError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  state.message,
                  style: fontBody.copyWith(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<BookmarkBloc>().add(LoadBookmarkedJobs());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorResources.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('ลองใหม่'),
                ),
              ],
            ),
          );
        }

        if (state is BookmarkEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bookmark_border,
                  size: 80,
                  color: ColorResources.colorPorpoise,
                ),
                SizedBox(height: 16),
                Text(
                  'ยังไม่มีงานที่บันทึก',
                  style: fontHeader4.copyWith(color: ColorResources.colorCharcoal),
                ),
                SizedBox(height: 8),
                Text(
                  'เลื่อนการ์ดลงเพื่อบันทึกงาน',
                  style: fontBody.copyWith(color: ColorResources.colorPorpoise),
                ),
              ],
            ),
          );
        }

        if (state is BookmarkLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<BookmarkBloc>().add(LoadBookmarkedJobs());
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.jobs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final job = state.jobs[index];
                return BookmarkJobCard(
                  job: job,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobDetailScreen(jobId: job.id),
                    ),
                  ),
                );
              },
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}

// Applied Jobs Tab (ยังใช้ mock data)
class AppliedJobsTab extends StatelessWidget {
  const AppliedJobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outline,
            size: 80,
            color: ColorResources.colorPorpoise,
          ),
          SizedBox(height: 16),
          Text(
            'ยังไม่มีงานที่สมัคร',
            style: fontHeader4.copyWith(color: ColorResources.colorCharcoal),
          ),
        ],
      ),
    );
  }
}

// BookmarkJobCard - รับ JobModel แทน Map
class BookmarkJobCard extends StatelessWidget {
  final dynamic job; // JobModel
  final VoidCallback? onTap;

  const BookmarkJobCard({
    super.key,
    required this.job,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 156,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorResources.colorCloud, width: 1),
        ),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                      job.company.logoUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.orange,
                          child: Icon(Icons.business, color: Colors.white),
                        );
                      },
                    ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: fontTitleStrong.copyWith(
                            color: ColorResources.colorCharcoal),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        job.company.name,
                        style: fontBody.copyWith(
                            color: ColorResources.colorPorpoise),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  spacing: 4,
                  children: [
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
                            '${(job.aiSkillMatch.percentage).round()}%',
                            style: fontSmallStrong.copyWith(
                                color: Color(0xFF596DF8)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: ColorResources.buttonColor, width: 1),
                      ),
                      child: Icon(
                        Icons.bookmark_rounded,
                        color: ColorResources.buttonColor,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.work_outline,
                      size: 18,
                      color: ColorResources.colorPorpoise,
                    ),
                    const SizedBox(width: 8),
                    Text(
                        '${job.employment.seniority}, ${job.employment.type}',
                        style: fontSmall.copyWith(
                            color: ColorResources.colorPorpoise)),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: ColorResources.colorPorpoise,
                    ),
                    const SizedBox(width: 8),
                    Text(job.location.city,
                        style: fontSmall.copyWith(
                            color: ColorResources.colorPorpoise)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 18,
                          color: ColorResources.colorPorpoise,
                        ),
                        const SizedBox(width: 8),
                        Text(job.salaryRange.formattedRange,
                            style: fontSmall.copyWith(
                                color: ColorResources.colorPorpoise)),
                      ],
                    ),
                    Text(job.postedAgo,
                        style: fontSmall.copyWith(
                            color: ColorResources.colorFlint)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}