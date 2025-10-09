import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobdeeo/src/features/questionnaire/widgets/questionaire_components.dart';

import '../bloc/questionnaire_bloc.dart';
import '../bloc/questionnaire_event.dart';
import '../bloc/questionnaire_state.dart';
import '../models/questionnaire_models.dart';
import '../screen/completion_screen.dart';

class DetailedDataTab extends StatelessWidget {
  final VoidCallback? onBackToFirstTab;

  const DetailedDataTab({
    super.key,
    this.onBackToFirstTab,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data จากรูป
    final List<String> organizationOptions = [
      'องค์กรใหญ่', 'สตาร์ทอัพ / ทีมเล็ก', 'ทำงานกับต่างชาติ', 'ราชการ', 'องค์กรรัฐ'
    ];

    final List<String> vibesOptions = [
      'Impactful Work', 'Creative Playground', 'Tech Forward', 'ท้าทายตัวเอง', 'ชิลๆ สบายๆ',
      'Mentor support', 'Networking', 'Event/Conference', 'จับงานหลากหลาย'
    ];

    final List<String> lifestyleOptions = [
      'Outing', 'ลาวันเกิด', 'ลาในวันที่ใจไม่พร้อม', 'Fitness', 'Party',
      'โซนผ่อนคลาย', 'อาหารเช้า/เที่ยง', 'ขนมและของว่าง', 'Mental Health'
    ];

    final List<String> motivationOptions = [
      'เงินเดือนและโบนัส', 'วัฒนธรรมองค์กร', 'เพื่อนร่วมงาน', 'ได้เติบโตในสายงาน',
      'ทำงานเพื่อสังคม/สิ่งแวดล้อม', 'ได้ใช้ความคิดสร้างสรรค์','ได้ทำงานที่มี Impact จริง', 'งานที่ทำให้ลูกค้าแฮปปี้'
    ];

    return BlocConsumer<QuestionnaireBloc, QuestionnaireState>(
      listener: (context, state) {
        if (state is QuestionnaireCompleted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CompletionScreen(data: state.data),
            ),
          );
        } else if (state is QuestionnaireError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final detailedData = state is QuestionnaireUpdated
            ? state.detailedData
            : const QuestionnaireDetailedData();
        final isLoading = state is QuestionnaireLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MainSectionHeader(title: 'ลักษณะองค์กร'),
                    MultiSelectChip(
                      options: organizationOptions,
                      selectedValues: detailedData.organizationTypes,
                      onSelectionChanged: (value) {
                        context.read<QuestionnaireBloc>().add(ToggleOrganizationType(value));
                      },
                    ),
                  ],
                ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainSectionHeader(title: 'Vibes ที่ต้องการ'),
                MultiSelectChip(
                  options: vibesOptions,
                  selectedValues: detailedData.workVibes,
                  onSelectionChanged: (value) {
                    context.read<QuestionnaireBloc>().add(ToggleWorkVibe(value));
                  },
                ),
                ],
            ),

            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const MainSectionHeader(title: 'สไตล์ชีวิตที่อยากได้'),
                MultiSelectChip(
                  options: lifestyleOptions,
                  selectedValues: detailedData.lifestylePreferences,
                  onSelectionChanged: (value) {
                    context.read<QuestionnaireBloc>().add(ToggleLifestylePreference(value));
                  },
                ),
                ],
            ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const MainSectionHeader(title: 'อะไรที่ทำให้อยากทำงาน'),
                MultiSelectChip(
                  options: motivationOptions,
                  selectedValues: detailedData.workMotivations,
                  onSelectionChanged: (value) {
                    context.read<QuestionnaireBloc>().add(ToggleWorkMotivation(value));
                  },
                ),
              ],
            ),
            ],
            ),
          ),

          bottomNavigationBar: StickyBottomButtons(
            submitText: 'บันทึก',
            cancleText: 'ย้อนกลับ',
            isLoading: isLoading,
            onCancel: () {
              onBackToFirstTab?.call();
            },
            onSubmit: () {
              context.read<QuestionnaireBloc>().add(SubmitCompleteData());
            },
          ),
        );
      },
    );
  }
}