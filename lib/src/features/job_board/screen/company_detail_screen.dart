import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';

import '../../../core/color_resources.dart';
import '../bloc/company/company_bloc.dart';
import '../bloc/company/company_event.dart';
import '../bloc/company/company_state.dart';
import '../bloc/job/job_bloc.dart';
import '../bloc/job/job_event.dart';
import '../widgets/company_section/company_tab_content.dart';

class CompanyDetailScreen extends StatefulWidget {
  final String companyId;

  const CompanyDetailScreen({super.key, required this.companyId});

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    context.read<CompanyBloc>().add(LoadCompanyDetail(widget.companyId));
    // Load company jobs for the positions tab
    context.read<JobBloc>().add(LoadAllJobs());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        String companyName = '';

        if (state is CompanyDetailLoaded) {
          companyName = state.company.name;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CompanyDetailAppBar(companyName: companyName),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(CompanyState state) {
    if (state is CompanyLoading) {
      return const CompanyDetailLoading();
    } else if (state is CompanyDetailLoaded) {
      final company = state.company;
      return Column(
        children: [
          CompanyTabBar(tabController: _tabController),
          Expanded(
            child: CompanyTabContent(
              tabController: _tabController,
              company: company,
              companyId: widget.companyId,
            ),
          ),
        ],
      );
    } else if (state is CompanyError) {
      return CompanyDetailError(
        message: state.message,
        onRetry: () => context.read<CompanyBloc>().add(LoadCompanyDetail(widget.companyId)),
      );
    }
    return const SizedBox.shrink();
  }
}

class CompanyDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String companyName;

  const CompanyDetailAppBar({
    super.key,
    required this.companyName,
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
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: ColorResources.buttonColor),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        companyName,
        style: fontHeader5.copyWith(color: ColorResources.colorCharcoal),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
        )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CompanyTabBar extends StatelessWidget {
  final TabController tabController;

  const CompanyTabBar({
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
        Tab(child: Text( 'ข้อมูลบริษัท', style: fontBody)),
          Tab(child: Text( 'สวัสดิการ', style: fontBody)),
            Tab(child: Text( 'ไลฟ์สไตล์', style: fontBody)),
              Tab(child: Text( 'ติดต่อ', style: fontBody)),
                Tab(child: Text( 'ตำแหน่งที่เปิดรับ', style: fontBody)),
        ],
      ),
    );
  }
}

class CompanyDetailLoading extends StatelessWidget {
  const CompanyDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: Colors.teal),
    );
  }
}

class CompanyDetailError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CompanyDetailError({
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
}