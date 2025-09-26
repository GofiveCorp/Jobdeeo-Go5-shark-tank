import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            const JobBoardHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildRecommendedJobsSection(),
                    const SizedBox(height: 32),
                    _buildTopCompaniesSection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedJobsSection() {
    return Column(
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
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: BlocBuilder<JobBloc, JobState>(
            builder: (context, state) {
              if (state is JobLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is JobLoaded) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) {
                    final job = state.jobs[index];
                    return JobCard(
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
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: BlocBuilder<CompanyBloc, CompanyState>(
            builder: (context, state) {
              if (state is CompanyLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CompanyLoaded) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.companies.length,
                  itemBuilder: (context, index) {
                    final company = state.companies[index];
                    return CompanyCard(
                      company: company,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyDetailScreen(
                            companyId: company.id,
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

// Header Widget with new design
class JobBoardHeader extends StatelessWidget {
  const JobBoardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF26C6DA), Color(0xFF00ACC1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const HeaderTopSection(),
          const HeaderMiddleSection(),
          HeaderSearchSection(),
          const SizedBox(height: 16),
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
      padding: const EdgeInsets.all(16),
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.bookmark_outline,
                color: Colors.white,
                size: 24,
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'โอกาสงานดี ๆ กำลังรอคุณอยู่!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'ก้าวหน้าในอาชีพของคุณ\nพร้อมเชื่อมต่อกับบริษัทชั้นนำระดับแนวหน้า',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.4,
            ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AdvancedSearchScreen(),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.grey[600],
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'ค้นหางานหรือบริษัท',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}