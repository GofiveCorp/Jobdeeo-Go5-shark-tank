import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';
import 'package:jobdeeo/src/features/job_board/screen/search_screen.dart';
import '../../../../utils/time_utils.dart';
import '../bloc/job/job_bloc.dart';
import '../bloc/job/job_event.dart';
import '../bloc/job/job_state.dart';
import 'advanced_search_screen.dart';
import 'job_detail_screen.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<JobBloc>().add(LoadAllJobs());
  }
  bool _showAllJobs = true;
  List _allCompanyJobs = [];
  void _toggleFilter(List allJobs) {
    setState(() {
      _showAllJobs = !_showAllJobs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: ColorResources.buttonColor),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
                'งานแนะนำ',
                style: fontHeader5.copyWith(color: ColorResources.colorCharcoal)
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
        children: [
          // Search Bar
          Container(
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdvancedSearchScreen(),
                      ),
                    ),
                    child: Container(
                      height: 36,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: ColorResources.colorCloud, width: 1),
                      ),
                      child: Row(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.search_rounded, color: ColorResources.colorFlint, size: 16),
                          Text('ค้นหางานหรือบริษัท',style: fontBody.copyWith(color: ColorResources.colorSilver))
                        ],
                      ),
                    ),
                  ),
                ),
                // Filter Buttons
                Row(
                  spacing: 4,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!_showAllJobs) {
                          _toggleFilter(_allCompanyJobs);
                        }
                      },
                      child: Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: _showAllJobs ? ColorResources.primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: _showAllJobs ? ColorResources.primaryColor : ColorResources.colorSmoke,
                              width: 1
                          ),
                        ),
                        child: Text(
                            'ทั้งหมด',
                            style: _showAllJobs
                                ?fontBodyStrong.copyWith(color: Colors.white)
                                :fontBody.copyWith(color: ColorResources.colorDarkGray)
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<JobBloc>().add(SortJobsByDate());
                      },
                      child: Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: !_showAllJobs ? ColorResources.primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: !_showAllJobs ? ColorResources.primaryColor : ColorResources.colorSmoke,
                              width: 1
                          ),
                        ),
                        child: Text(
                            'ล่าสุด',
                            style: !_showAllJobs
                                ?fontBodyStrong.copyWith(color: Colors.white)
                                :fontBody.copyWith(color: ColorResources.colorDarkGray)
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Job List
          Expanded(
            child: BlocBuilder<JobBloc, JobState>(
              builder: (context, state) {
                if (state is JobLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.teal),
                  );
                } else if (state is JobLoaded) {
                  if (state.jobs.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.work_off,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'ไม่พบงานที่แนะนำ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: state.jobs.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final job = state.jobs[index];
                      return JobListCard(
                        job: job,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetailScreen(jobId: job.id),
                          ),
                        ).then((shouldRefresh) {
                          if (shouldRefresh == true) {
                            context.read<JobBloc>().add(LoadAllJobs());
                          }
                        }),
                      );
                    },
                  );
                } else if (state is JobError) {
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
                          state.message,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<JobBloc>().add(LoadAllJobs());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('ลองใหม่'),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
        ),
      ),
    );
  }
}

class JobListCard extends StatelessWidget {
  final job;
  final VoidCallback? onTap;

  const JobListCard({
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
                Image.asset(
                  job.companyLogo,
                  width: 48,
                  height: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: fontTitleStrong.copyWith(color: ColorResources.colorCharcoal),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        job.companyName,
                        style: fontBody.copyWith(color: ColorResources.colorPorpoise),
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
                        '${job.matchPercentage}%',
                        style: fontSmallStrong.copyWith(color : Color(0xFF596DF8)),
                      )
                    ],
                  ),
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
                        '${job.level}, ${job.workType}',
                        style: fontSmall.copyWith(color: ColorResources.colorPorpoise)
                    ),
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
                    Text(
                        job.location,
                        style: fontSmall.copyWith(color: ColorResources.colorPorpoise)
                    ),
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
                        Text(
                            job.salaryRange,
                            style: fontSmall.copyWith(color: ColorResources.colorPorpoise)
                        ),
                      ],
                    ),
                    Text(
                        TimeUtils.getTimeAgo(job.postedAt),
                        style: fontSmall.copyWith(color: ColorResources.colorFlint)
                    ),
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