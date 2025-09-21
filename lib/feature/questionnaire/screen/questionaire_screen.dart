import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/questionnaire_bloc.dart';
import '../widgets/basic_data_tab.dart';
import '../widgets/detailed_data_tab.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen>
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

  void _onTabChange(int index) {
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionnaireBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
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
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF24CAB1)),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'เลือกความสนใจ',
                style: TextStyle(color: Color(0xFF1C1C22), fontWeight: FontWeight.w700, fontSize: 18),
              ),
              centerTitle: true,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: Color(0xFF24CAB1),
                unselectedLabelColor: Color(0xFF838395),
                indicatorColor: Color(0xFF24CAB1),
                indicatorWeight: 2,
                dividerColor: Colors.transparent, // Remove grey underline
                isScrollable: true, // Enable scrollable tabs
                tabAlignment: TabAlignment.start, // Align tabs to start (left)
                indicatorSize: TabBarIndicatorSize.label, // Make indicator fit label width
                labelPadding: EdgeInsets.only(right: 30, left: 0), // 30px spacing between tabs
                padding: EdgeInsets.symmetric(horizontal: 16), // Add padding from screen edge
                tabs: const [
                  Tab(text: 'ข้อมูลพื้นฐาน'),
                  Tab(text: 'ข้อมูลเชิงลึก'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BasicDataTab(onTabChange: _onTabChange),
                  const DetailedDataTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}