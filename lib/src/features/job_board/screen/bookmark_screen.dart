import 'package:flutter/material.dart';

import '../widgets/job_section/job_tab_content.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BookmarkAppBar(),
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
    );
  }
}

// App Bar
class BookmarkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookmarkAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.teal),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'งานของฉัน',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
        labelColor: Colors.teal,
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: Colors.teal,
        indicatorWeight: 2,
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('งานที่บันทึก'),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('งานที่สมัคร'),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
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

// Saved Jobs Tab
class SavedJobsTab extends StatelessWidget {
  const SavedJobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for saved jobs
    final savedJobs = [
      {
        'id': '1',
        'title': 'UX/UI Designer',
        'company': 'Gofive',
        'level': 'Senior',
        'type': 'Full time',
        'location': 'Bangkok',
        'salary': '200,000 - 350,000',
        'match': '89%',
        'time': '1m ago',
        'applicationDate': null,
        'hasBookmarkIcon': true,
      },
      {
        'id': '2',
        'title': 'Sales Manager',
        'company': 'Gofive',
        'level': 'Senior',
        'type': 'Full time',
        'location': 'Bangkok',
        'salary': '200,000 - 350,000',
        'match': '79%',
        'time': '1m ago',
        'applicationDate': null,
        'hasBookmarkIcon': true,
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: savedJobs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final job = savedJobs[index];
        return BookmarkJobCard(
          job: job,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailScreen(
                jobId: job['id'] as String,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Applied Jobs Tab
class AppliedJobsTab extends StatelessWidget {
  const AppliedJobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for applied jobs
    final appliedJobs = [
      {
        'id': '3',
        'title': 'UX/UI Designer',
        'company': 'Gofive',
        'level': 'Senior',
        'type': 'Full time',
        'location': 'Bangkok',
        'salary': '200,000 - 350,000',
        'match': '89%',
        'time': '1m ago',
        'applicationDate': 'สมัครเมื่อ 9/9/68',
        'hasApplicationIcon': true,
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: appliedJobs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final job = appliedJobs[index];
        return BookmarkJobCard(
          job: job,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppliedJobDetailScreen(
                jobId: job['id'] as String,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Job Card for both tabs
class BookmarkJobCard extends StatelessWidget {
  final Map<String, dynamic> job;
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
                        job['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job['company'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
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
                            job['match'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.purple[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (job['hasBookmarkIcon'] == true)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.bookmark,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    if (job['hasApplicationIcon'] == true)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                  ],
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
                  '${job['level']}, ${job['type']}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
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
                  job['location'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    job['salary'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Text(
                  job['applicationDate'] ?? job['time'],
                  style: TextStyle(
                    fontSize: 12,
                    color: job['applicationDate'] != null ? Colors.teal : Colors.grey[500],
                    fontWeight: job['applicationDate'] != null ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Applied Job Detail Screen (without bottom bar)
class AppliedJobDetailScreen extends StatefulWidget {
  final String jobId;

  const AppliedJobDetailScreen({super.key, required this.jobId});

  @override
  State<AppliedJobDetailScreen> createState() => _AppliedJobDetailScreenState();
}

class _AppliedJobDetailScreenState extends State<AppliedJobDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    // Note: In real app, you would load job details here
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mock job data for applied job detail
    const jobTitle = 'Administrative Officer';
    const companyName = 'Gofive Co., Ltd';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppliedJobDetailAppBar(
        jobTitle: jobTitle,
        companyName: companyName,
      ),
      body: Column(
        children: [
          AppliedJobTabBar(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                AppliedJobOverviewTab(),
                ResponsibilitiesTab(),
                QualificationsTab(),
                LifestyleTab(),
                ContactTab(),
              ],
            ),
          ),
        ],
      ),
      // No bottom navigation bar for applied jobs
    );
  }
}

// Applied Job Detail App Bar
class AppliedJobDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String jobTitle;
  final String companyName;

  const AppliedJobDetailAppBar({
    super.key,
    required this.jobTitle,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.teal),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
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
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Applied Job Tab Bar
class AppliedJobTabBar extends StatelessWidget {
  final TabController tabController;

  const AppliedJobTabBar({
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

// Applied Job Overview Tab
class AppliedJobOverviewTab extends StatelessWidget {
  const AppliedJobOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job Header with application status
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.business,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Administrative Officer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Gofive Co., Ltd',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'สมัครเมื่อ 9/9/68',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.teal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Skill Match Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[50]!, Colors.orange[50]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.diamond,
                  color: Colors.purple[600],
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  '89% Skill Matches',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Skills Section
          Row(
            children: [
              _buildSkillChip('Swift', 'สูง', Colors.green),
              const SizedBox(width: 8),
              _buildSkillChip('Kotlin', 'กลาง', Colors.purple),
              const SizedBox(width: 8),
              _buildSkillChip('Firebase', 'เบื้องต้น', Colors.blue),
            ],
          ),
          const SizedBox(height: 16),

          // Job Details
          _buildDetailRow(Icons.work_outline, 'Senior, Full-time'),
          const SizedBox(height: 8),
          _buildDetailRow(Icons.location_on_outlined, 'Bangkok'),
          const SizedBox(height: 8),
          _buildDetailRow(Icons.attach_money, '200,000 - 350,000'),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'ไม่โลก',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Text(
                  'M',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'สุขุมวิท',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Job Description Section
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: Colors.teal,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'ภาพรวมของตำแหน่งงาน',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'As a Systems Analyst, you will be responsible for analyzing, designing, and implementing computer systems to meet the needs of our organization. You can work individually on a project or collaborate with a team of other systems analysts on multiple projects.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill, String level, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            skill,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              level,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}