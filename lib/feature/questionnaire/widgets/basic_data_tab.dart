import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobdeeo/feature/questionnaire/widgets/questionaire_components.dart';

import '../bloc/questionnaire_bloc.dart';
import '../bloc/questionnaire_event.dart';
import '../bloc/questionnaire_state.dart';
import '../models/questionnaire_models.dart';

class BasicDataTab extends StatelessWidget {
  final Function(int) onTabChange;

  const BasicDataTab({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final List<String> jobLevelOptions = [
      'New-Grad', 'Junior', 'Mid-level', 'Senior', 'Manager', 'Lead', 'C-Level'
    ];

    final List<String> jobTypeOptions = [
      'งานประจำ', 'งานพาร์ทไทม์', 'ฟรีแลนซ์', 'งานสัญญาจ้าง', 'ฝึกงาน/สหกิจ'
    ];

    final List<String> workFormatOptions = [
      'On-site', 'Hybrid', 'Work from home', 'เลือกเวลางานเอง'
    ];

    final List<String> workPlaceOptions = [
      'งานใกล้บ้าน', 'ติดรถไฟฟ้า', 'ติดสายรถเมล์', 'ออฟฟิศส่วนตัว', 'ตึกสำนักงาน', 'Home Office'
    ];

    return BlocConsumer<QuestionnaireBloc, QuestionnaireState>(
      listener: (context, state) {
        if (state is QuestionnaireBasicSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('บันทึกข้อมูลสำเร็จ!'),
              backgroundColor: Color(0xFF24CAB1),
            ),
          );
          onTabChange(1);
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
        final basicData = state is QuestionnaireUpdated
            ? state.basicData
            : const QuestionnaireBasicData();
        final isLoading = state is QuestionnaireLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SubSectionHeader(title: 'ตำแหน่งงานที่ต้องการ'),
                CustomTextField(
                  hintText: 'กรอกตำแหน่งงาน',
                  initialValue: basicData.jobPosition,
                  isOptional: true,
                  onChanged: (value) {
                    context.read<QuestionnaireBloc>().add(UpdateJobPosition(value));
                  },
                ),

                const SubSectionHeader(title: 'เงินเดือนที่คาดหวัง'),
                CustomTextField(
                  hintText: 'กรอกตัวเลข เช่น 25000',
                  initialValue: basicData.expectedSalary,
                  onChanged: (value) {
                    context.read<QuestionnaireBloc>().add(UpdateExpectedSalary(value));
                  },
                  onAddPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('คุณสามารถข้ามได้หากไม่ต้องการระบุ')),
                    );
                  },
                ),

                const MainSectionHeader(title: 'ตำแหน่งงาน'),
                MultiSelectChip(
                  options: jobLevelOptions,
                  selectedValues: basicData.jobLevels,
                  onSelectionChanged: (value) {
                    context.read<QuestionnaireBloc>().add(ToggleJobLevel(value));
                  },
                ),

                const MainSectionHeader(title: 'ประเภทงานที่สนใจ'),
                MultiSelectChip(
                  options: jobTypeOptions,
                  selectedValues: basicData.jobTypes,
                  onSelectionChanged: (value) {
                    context.read<QuestionnaireBloc>().add(ToggleJobType(value));
                  },
                ),

                const MainSectionHeader(title: 'การเข้าทำงาน'),
                MultiSelectChip(
                  options: workFormatOptions,
                  selectedValues: basicData.workFormats,
                  onSelectionChanged: (value) {
                    context.read<QuestionnaireBloc>().add(ToggleWorkFormat(value));
                  },
                ),

                const MainSectionHeader(title: 'สถานที่ทำงาน'),
                MultiSelectChip(
                  options: workPlaceOptions,
                  selectedValues: basicData.workPlaceTypes,
                  onSelectionChanged: (value) {
                    context.read<QuestionnaireBloc>().add(ToggleWorkFormat(value));
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: StickyBottomButtons(
            submitText: 'บันทึกและไปต่อ',
            isLoading: isLoading,
            onCancel: () => Navigator.pop(context),
            onSubmit: () {
              context.read<QuestionnaireBloc>().add(SubmitBasicData());
            },
          ),
        );
      },
    );
  }
}