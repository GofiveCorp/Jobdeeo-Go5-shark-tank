import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobdeeo/src/features/questionnaire/widgets/questionaire_components.dart';
import '../../../core/base/txt_styles.dart';
import '../../../core/color_resources.dart';
import '../../../core/services/preferences_service.dart';
import '../bloc/questionnaire_bloc.dart';
import '../bloc/questionnaire_event.dart';
import '../bloc/questionnaire_state.dart';
import '../models/questionnaire_models.dart';

class BasicDataTab extends StatefulWidget {
  final Function(int) onTabChange;

  const BasicDataTab({super.key, required this.onTabChange});

  @override
  State<BasicDataTab> createState() => _BasicDataTabState();
}

class _BasicDataTabState extends State<BasicDataTab> {
  List<TextEditingController> _jobPositionControllers = [TextEditingController()];
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _jobPositionControllers[0].addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _jobPositionControllers[0].text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    for (var controller in _jobPositionControllers) {
      controller.removeListener(_validateForm);
      controller.dispose();
    }
    super.dispose();
  }

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
            SnackBar(
              content: Text('บันทึกข้อมูลสำเร็จ!', style: fontBody.copyWith(color: Colors.white)),
              backgroundColor: ColorResources.primaryColor,
            ),
          );
          widget.onTabChange(1);
        } else if (state is QuestionnaireError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, style: fontBody.copyWith(color: Colors.white)),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubSectionHeader(title: 'ตำแหน่งงานที่ต้องการ'),
                    ...List.generate(_jobPositionControllers.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _jobPositionControllers[index],
                              hintText: 'กรอกตำแหน่งงาน',
                              isOptional: false,
                              onAddPressed: null,
                              onChanged: (value) {
                                if (index == 0) _validateForm();
                                context.read<QuestionnaireBloc>().add(UpdateJobPosition(value));
                              },
                            ),
                          ],
                        ),
                      );
                    }),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          final newController = TextEditingController();
                          _jobPositionControllers.add(newController);
                        });
                      },
                      child: Text(
                        '+ เพิ่ม',
                        style: fontBodyStrong.copyWith(color: ColorResources.primaryColor),
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubSectionHeader(title: 'เงินเดือนที่คาดหวัง'),
                    CustomTextField(
                      hintText: 'กรอกตัวเลข เช่น 25000',
                      onChanged: (value) {
                        context.read<QuestionnaireBloc>().add(UpdateExpectedSalary(value));
                      },
                    ),
                  ],
                ),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MainSectionHeader(title: 'ตำแหน่งงาน'),
                    MultiSelectChip(
                      options: jobLevelOptions,
                      selectedValues: basicData.jobLevels,
                      onSelectionChanged: (value) {
                        context.read<QuestionnaireBloc>().add(ToggleJobLevel(value));
                      },
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MainSectionHeader(title: 'ประเภทงานที่สนใจ'),
                    MultiSelectChip(
                      options: jobTypeOptions,
                      selectedValues: basicData.jobTypes,
                      onSelectionChanged: (value) {
                        context.read<QuestionnaireBloc>().add(ToggleJobType(value));
                      },
                    ),
                  ],
                ),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MainSectionHeader(title: 'การเข้าทำงาน'),
                    MultiSelectChip(
                      options: workFormatOptions,
                      selectedValues: basicData.workFormats,
                      onSelectionChanged: (value) {
                        context.read<QuestionnaireBloc>().add(ToggleWorkFormat(value));
                      },
                    ),
                  ],
                ),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MainSectionHeader(title: 'สถานที่ทำงาน'),
                    MultiSelectChip(
                      options: workPlaceOptions,
                      selectedValues: basicData.workPlaceTypes,
                      onSelectionChanged: (value) {
                        context.read<QuestionnaireBloc>().add(ToggleWorkPlaceType(value));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: StickyBottomButtons(
            submitText: 'บันทึกและไปต่อ',
            cancleText: 'ยกเลิก',
            isLoading: isLoading,
            isEnabled: _isFormValid,
            onCancel: () => Navigator.pop(context),
            onSubmit: () async {
              if (_isFormValid) {
                final positions = _jobPositionControllers
                    .map((controller) => controller.text.trim())
                    .where((text) => text.isNotEmpty)
                    .toList();

                await PreferencesService.setJobPositions(positions);

                widget.onTabChange(1);
                context.read<QuestionnaireBloc>().add(SubmitBasicData());
              }
            },
          ),
        );
      },
    );
  }
}