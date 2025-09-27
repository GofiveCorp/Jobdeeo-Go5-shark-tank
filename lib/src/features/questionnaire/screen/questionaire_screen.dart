import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';

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
                'เลือกความสนใจ',
                style: fontHeader5.copyWith(color: ColorResources.colorCharcoal)
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
                tabs: const [
                  Tab(child: Text('ข้อมูลพื้นฐาน', style: fontBody)),
                  Tab(child: Text('ข้อมูลเชิงลึก', style: fontBody)),
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