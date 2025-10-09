import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/features/job_board/repositories/job_repositories.dart';
import '../../../core/color_resources.dart';
import '../../../core/services/preferences_service.dart';
import '../../../dashboard/dashboard_screen.dart';
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
  bool _isQuestionnaireCompleted = false;

  @override
  void initState() {
    super.initState();
    _checkQuestionnaireStatus();
    context.read<JobBloc>().add(LoadRecommendedJobs());
    context.read<CompanyBloc>().add(LoadTopCompanies());
  }

  Future<void> _checkQuestionnaireStatus() async {
    final isCompleted = await PreferencesService.isQuestionnaireCompleted();
    setState(() {
      _isQuestionnaireCompleted = isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.backgroundColor,
      body: Column(
        children: [
          JobBoardHeader(isQuestionnaireCompleted: _isQuestionnaireCompleted),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!_isQuestionnaireCompleted) _buildCreateResumeNotice(),
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

  Widget _buildCreateResumeNotice() {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(initialIndex: 1),
          ),
              (route) => false,
        ).then((_) {
          _checkQuestionnaireStatus();
        });
      },
      child: Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          gradient: ColorResources.gd3Gradient.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
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
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Create resume to view matching score, ',
                      style: fontSmallStrong.copyWith(color: Color(0xFF596DF8)),
                    ),
                    TextSpan(
                      text: 'Click to Create',
                      style: fontSmallStrong.copyWith(color: Color(0xFF596DF8), decoration: TextDecoration.underline),
                    ),
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
      spacing: 8,
      children: [
        SectionHeader(
          title: 'Matches Jobs',
          actionText: 'View Job listings',
          onActionPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const JobListScreen(),
            ),
          ),
        ),
        SizedBox(
          height: _isQuestionnaireCompleted ? 260 : 246,
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
                        showMatchScore: _isQuestionnaireCompleted,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => JobBloc(JobRepositories())..add(LoadJobDetail(job.id)),
                              child: JobDetailScreen(jobId: job.id),
                            ),
                          ),
                        ).then((_) {
                          context.read<JobBloc>().add(LoadRecommendedJobs());
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
          title: 'Hot Companies',
          actionText: 'View All',
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
                        left: index == 0 ? 0 : 8,
                      ),
                      child: CompanyCard(
                        company: company,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => CompanyBloc()..add(LoadCompanyDetail(company.companyId)),
                              child: CompanyDetailScreen(companyId: company.companyId),
                            ),
                          ),
                        ).then((_) {
                          context.read<CompanyBloc>().add(LoadTopCompanies());
                        })
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
  final bool isQuestionnaireCompleted;

  const JobBoardHeader({
    super.key,
    required this.isQuestionnaireCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ColorResources.gd1Gradient,
      ),
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.only(right: 16, top: 48),
          child: isQuestionnaireCompleted ? HeaderTopSection() : SizedBox(height: 28),
              ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: null,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(81.25),
            ),
            child: Icon(
              Icons.notifications_rounded,
              color: ColorResources.primaryColor,
              size: 16,
            ),
          ),
        ),
      ],
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