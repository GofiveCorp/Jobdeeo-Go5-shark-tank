import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import '../../../core/color_resources.dart';
import '../bloc/company/company_bloc.dart';
import '../bloc/company/company_event.dart';
import '../bloc/company/company_state.dart';
import '../bloc/job/job_bloc.dart';
import '../bloc/job/job_event.dart';
import '../bloc/job/job_state.dart';
import '../widgets/company_card.dart';
import '../widgets/job_card.dart';
import '../widgets/section_header.dart';
import 'advanced_search_screen.dart';
import 'bookmark_screen.dart';
import 'company_detail_screen.dart';
import 'company_list_screen.dart';
import 'job_detail_screen.dart';
import 'job_list_screen.dart';

class JobBoardScreen extends StatefulWidget {
  const JobBoardScreen({super.key});

  @override
  State<JobBoardScreen> createState() => _JobBoardScreenState();
}

class _JobBoardScreenState extends State<JobBoardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<JobBloc>().add(LoadRecommendedJobs());
    context.read<CompanyBloc>().add(LoadTopCompanies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.backgroundColor,
      body: Column(
        children: [
          const JobBoardHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRecommendedJobsSection(),
                    _buildTopCompaniesSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedJobsSection() {
    return Column(
      spacing: 8,
      children: [
        SectionHeader(
          title: 'งานแนะนำ',
          actionText: 'ดูงานเพิ่มเติม',
          onActionPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const JobListScreen(),
            ),
          ),
        ),
        SizedBox(
          height: 260,
          child: BlocBuilder<JobBloc, JobState>(
            builder: (context, state) {
              if (state is JobLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is JobLoaded) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) {
                    final job = state.jobs[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 16,
                      ),
                      child: JobCard(
                        job: job,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetailScreen(jobId: job.id),
                          ),
                        ).then((shouldRefresh) {
                          if (shouldRefresh == true) {
                            context.read<JobBloc>().add(LoadRecommendedJobs());
                          }
                        }),
                      ),
                    );
                  },
                );
              } else if (state is JobError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopCompaniesSection() {
    return Column(
      spacing: 8,
      children: [
        SectionHeader(
          title: 'บริษัทชั้นนำ',
          actionText: 'ดูทั้งหมด',
          onActionPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CompanyListScreen(),
            ),
          ),
        ),
        SizedBox(
          height: 164,
          child: BlocBuilder<CompanyBloc, CompanyState>(
            builder: (context, state) {
              if (state is CompanyLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CompanyLoaded) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.companies.length,
                  itemBuilder: (context, index) {
                    final company = state.companies[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 16,
                      ),
                      child: CompanyCard(
                        company: company,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompanyDetailScreen(
                              companyId: company.id,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is CompanyError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}

class JobBoardHeader extends StatelessWidget {
  const JobBoardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ColorResources.gd1Gradient,
      ),
      child: Column(
        children: [
          const HeaderTopSection(),
          const HeaderMiddleSection(),
          HeaderSearchSection(),
        ],
      ),
    );
  }
}

// Top section with greeting and bookmark icon
class HeaderTopSection extends StatelessWidget {
  const HeaderTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BookmarkScreen(),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(81.25),
              ),
              child: Icon(
                Icons.bookmark,
                color: ColorResources.primaryColor,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Middle section with subtitle
class HeaderMiddleSection extends StatelessWidget {
  const HeaderMiddleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'โอกาสงานดี ๆ กำลังรอคุณอยู่!',
            style: fontHeader4.copyWith(color: Colors.white)
          ),
          SizedBox(height: 4),
          Text(
            'ก้าวหน้าในอาชีพของคุณ',
            style: fontSmall.copyWith(color: Colors.white)
          ),
          Text(
              'พร้อมเชื่อมต่อกับบริษัทชั้นนำระดับแนวหน้า',
              style: fontSmall.copyWith(color: Colors.white)
          ),
        ],
      ),
    );
  }
}

// Search section
class HeaderSearchSection extends StatelessWidget {
  const HeaderSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdvancedSearchScreen(),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: ColorResources.colorFlint,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'ค้นหางานหรือบริษัท',
                  style: fontBody.copyWith(color: ColorResources.colorFlint)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}