import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/job/job_bloc.dart';
import '../../bloc/job/job_state.dart';
import '../../models/company_model.dart';
import '../../screen/job_detail_screen.dart';

class CompanyTabContent extends StatelessWidget {
  final TabController tabController;
  final CompanyModel company;
  final String companyId;

  const CompanyTabContent({
    super.key,
    required this.tabController,
    required this.company,
    required this.companyId,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        CompanyInfoTab(company: company),
        CompanyBenefitsTab(),
        CompanyLifestyleTab(),
        CompanyContactTab(),
        CompanyJobsTab(companyId: companyId, companyName: company.name),
      ],
    );
  }
}

// Company Info Tab
class CompanyInfoTab extends StatelessWidget {
  final CompanyModel company;

  const CompanyInfoTab({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company Logo and Name (again for tab content)
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: company.name == 'บริษัท โซว์ไรจ์นิล จำกัด'
                      ? Colors.blue[600]
                      : Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: company.name == 'บริษัท โซว์ไรจ์นิล จำกัด'
                      ? const Text(
                    'bt',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                      : const Icon(
                    Icons.business,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  company.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Company Description
          Text(
            company.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),

          if (company.name == 'Gofive Company Limited') ...[
            const SizedBox(height: 24),
            Text(
              'Gofive คือบริษัท Startup ใน T.K.S. Group เราสร้าง Tech Ecosystem ที่เป็นแข็งแกร่งเพื่อผลักดันธุรกิจให้ Scale Up แบบก้าวกระโดดพร้อมกับ Career Path ที่มั่นคงในการทำงานที่ Gofive เราให้ความสำคัญในการใส่ใจเพื่อร่วมงาน รวมไปถึงการเปิดใจรับฟังและเรียนรู้สิ่งใหม่ๆอยู่เสมอ เพื่อให้ทีมงานของเรานั้นน่าอยู่สำหรับทุกคน',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'เรามี Products อะไรบ้าง?',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            CompanyProductsList(),
            const SizedBox(height: 24),
            Text(
              'มารู้จักเรามากขึ้น?',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'บรรยากาศการทำงานที่ Gofive: https://youtu.be/LLRtw5_n764 \n\nติดตามเราที่: www.facebook.com/GofiveFamily',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Company Benefits Tab
class CompanyBenefitsTab extends StatelessWidget {
  const CompanyBenefitsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.card_giftcard,
                color: Colors.teal,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'สวัสดิการ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BenefitsList(),
        ],
      ),
    );
  }
}

// Company Lifestyle Tab (similar to job detail lifestyle)
class CompanyLifestyleTab extends StatelessWidget {
  const CompanyLifestyleTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Row 1
          Row(
            children: [
              Expanded(
                child: CompanyVideoCard(
                  title: 'วิธีเดินทางมาที่งาน',
                  company: 'Gofive Co., Ltd',
                  likes: '2228',
                  duration: '01:59',
                  isVideoPost: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CompanyVideoCard(
                  title: 'วิธีเดินทางมาที่งาน',
                  company: 'Gofive Co., Ltd',
                  likes: '2228',
                  duration: '',
                  isVideoPost: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Row 2
          Row(
            children: [
              Expanded(
                child: CompanyVideoCard(
                  title: 'AI ช่วยเตรียมตัวสัมภาษณ์งาน',
                  company: 'Gofive Co., Ltd',
                  likes: '2228',
                  duration: '',
                  isVideoPost: false,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}

// Company Contact Tab
class CompanyContactTab extends StatelessWidget {
  const CompanyContactTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'At Gofive, we share a passion for driving digital transformation for businesses of all sizes. We pay attention to every detail and are committed to delivering an exceptional software experience to our users.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.location_city,
                color: Colors.teal,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'การติดต่อ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'สาขาพระราม 2  |  สาขา FYI Center (พระรามที่ 4)',
            style: TextStyle(
              fontSize: 14,
              color: Colors.teal,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          CompanyLocationMap(),
        ],
      ),
    );
  }
}

// Company Jobs Tab
class CompanyJobsTab extends StatelessWidget {
  final String companyId;
  final String companyName;

  const CompanyJobsTab({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return CompanyJobsWidget(
      companyId: companyId,
      companyName: companyName,
    );
  }
}

class CompanyJobsWidget extends StatefulWidget {
  final String companyId;
  final String companyName;

  const CompanyJobsWidget({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  State<CompanyJobsWidget> createState() => _CompanyJobsWidgetState();
}

class _CompanyJobsWidgetState extends State<CompanyJobsWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool _showAllJobs = true; // true = All, false = Newest
  List _filteredJobs = [];
  List _allCompanyJobs = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(List allJobs) {
    setState(() {
      if (_searchController.text.trim().isEmpty) {
        _filteredJobs = _allCompanyJobs;
      } else {
        _filteredJobs = _allCompanyJobs
            .where((job) =>
        job.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            job.companyName.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();
      }

      // Apply sorting
      if (!_showAllJobs) {
        _filteredJobs.sort((a, b) => b.postedAt.compareTo(a.postedAt));
      }
    });
  }

  void _toggleFilter(List allJobs) {
    setState(() {
      _showAllJobs = !_showAllJobs;
      _performSearch(allJobs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search and Filter
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[600], size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => _performSearch(_allCompanyJobs),
                        decoration: InputDecoration(
                          hintText: 'ค้นหาตำแหน่งงาน',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Filter Buttons
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!_showAllJobs) {
                        _toggleFilter(_allCompanyJobs);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: _showAllJobs ? Colors.teal : Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: _showAllJobs ? Colors.teal : Colors.grey[300]!,
                        ),
                      ),
                      child: Text(
                        'All',
                        style: TextStyle(
                          color: _showAllJobs ? Colors.white : Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      if (_showAllJobs) {
                        _toggleFilter(_allCompanyJobs);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: !_showAllJobs ? Colors.teal : Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: !_showAllJobs ? Colors.teal : Colors.grey[300]!,
                        ),
                      ),
                      child: Text(
                        'Newest',
                        style: TextStyle(
                          color: !_showAllJobs ? Colors.white : Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Jobs List
        Expanded(
          child: BlocBuilder<JobBloc, JobState>(
            builder: (context, state) {
              if (state is JobLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.teal),
                );
              } else if (state is JobLoaded) {
                // Filter jobs by company
                final companyJobs = state.jobs
                    .where((job) => job.companyName == widget.companyName)
                    .toList();

                // Update all company jobs for filtering
                if (_allCompanyJobs != companyJobs) {
                  _allCompanyJobs = companyJobs;
                  _filteredJobs = companyJobs;
                }

                if (_filteredJobs.isEmpty && _searchController.text.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'ไม่พบตำแหน่ง "${_searchController.text}"',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (companyJobs.isEmpty) {
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
                          'ไม่มีตำแหน่งที่เปิดรับในขณะนี้',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredJobs.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final job = _filteredJobs[index];
                    return CompanyJobCard(
                      job: job,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetailScreen(jobId: job.id),
                        ),
                      ),
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
                    ],
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

// Reusable Widgets
class CompanyProductsList extends StatelessWidget {
  const CompanyProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      'Venio โปรแกรม CRM บริหารกับขายอันดับ 1 การันตีด้วยรางวัลดำเนิน ICT Award www.veniocrm.com',
      'empeo โปรแกรม HRM บริหารงานบุคคลอย่างครบวงจร ที่ได้รับความไว้วางใจจากลูกค้าชั้นนำ www.empeo.com',
      'Salesbear โปรแกรมตอบแชท ที่เป็น Partner ของ LINE Official โดยตรง www.salesbear.com',
    ];

    return Column(
      children: products.map((product) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 6, right: 12),
              decoration: const BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(
                product,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

class BenefitsList extends StatelessWidget {
  const BenefitsList({super.key});

  @override
  Widget build(BuildContext context) {
    final benefits = [
      'Performance Bonus ประจำปี',
      'กองทุนสำรองเลี้ยงชีพ',
      'ประกันสุขภาพกลุ่ม ประกันอุบัติเหตุ ประกันชีวิต',
      'คอร์สเรียน Upskill ได้ตามต้องการ',
      'Notebook ส่วนตัว หรือถ้าอยากใช้ของตัวเองก็มี Reward ให้',
      'Outing ท่องเที่ยวประจำปี',
      'กิจกรรมจัดเต็มตลอดทั้งปี',
      'ออฟฟิศใจกลางเมืองเดินทางสะดวกที่ FYI Center ติด MRT ศูนย์ประชุมแห่งชาติสีลรักษ์',
    ];

    return Column(
      children: benefits.map((benefit) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 6, right: 12),
              decoration: const BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(
                benefit,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

class CompanyVideoCard extends StatelessWidget {
  final String title;
  final String company;
  final String likes;
  final String duration;
  final bool isVideoPost;

  const CompanyVideoCard({
    super.key,
    required this.title,
    required this.company,
    required this.likes,
    required this.duration,
    required this.isVideoPost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Thumbnail
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Colors.grey[100],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.video_library,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),

                if (isVideoPost && duration.isNotEmpty)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            duration,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Card Content
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.business,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        company,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.favorite_border,
                      size: 12,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 2),
                    Text(
                      likes,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CompanyJobCard extends StatelessWidget {
  final job;
  final VoidCallback? onTap;

  const CompanyJobCard({
    super.key,
    required this.job,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.business,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job.companyName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.purple[200]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.diamond,
                        size: 14,
                        color: Colors.purple[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${job.matchPercentage}%',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.purple[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Icon(
                  Icons.work_outline,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  '${job.level}, ${job.workType}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                Text(
                  _getTimeAgo(job.postedAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  job.location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                Text(
                  job.salaryRange,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'เพิ่งลง';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    }
  }
}

class CompanyLocationMap extends StatelessWidget {
  const CompanyLocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              size: 40,
              color: Colors.grey,
            ),
            SizedBox(height: 8),
            Text(
              'แผนที่ตำแหน่งบริษัท',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}