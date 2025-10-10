import 'package:flutter/material.dart';
import 'package:jobdeeo/src/core/base/color_resource.dart';
import 'package:jobdeeo/src/core/base/image_resource.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/features/questionnaire/screen/questionaire_screen.dart';

class EmsumeInfomationScreen extends StatefulWidget {
  const EmsumeInfomationScreen({Key? key}) : super(key: key);

  @override
  State<EmsumeInfomationScreen> createState() => _EmsumeInfomationScreenState();
}

class _EmsumeInfomationScreenState extends State<EmsumeInfomationScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedTitle;
  String? _gender;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
          bodyLarge: fontBody.copyWith(color: ColorResources.colorCharcoal),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: fontBody.copyWith(color: ColorResources.colorFlint),
          labelStyle: fontBody.copyWith(color: ColorResources.colorFlint),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: ColorResources.buttonColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("สร้าง emsume", style: fontHeader5),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "สร้าง emsume",
                      style: fontBody.copyWith(
                        color: ColorResources.colorPorpoise,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Step progress
                  Container(
                    decoration: BoxDecoration(
                                          color: ColorResources.searchBg,
                                              borderRadius: BorderRadius.all(Radius.circular(4.0)),


                     ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: List.generate(6, (index) {
                        //     return Container(
                        //       margin: const EdgeInsets.symmetric(horizontal: 6),
                        //       width: 28,
                        //       height: 28,
                        //       decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         color:
                        //             index == 0
                        //                 ? ColorResources.colorFlame
                        //                 : Colors.white,
                        //         border: Border.all(
                        //           color:
                        //               index == 0
                        //                   ? ColorResources.colorFlame
                        //                   : ColorResources.colorFlint,
                        //         ),
                        //       ),
                        //       child: Center(
                        //         child: Text(
                        //           "${index + 1}",
                        //           style: fontTitleStrong.copyWith(
                        //             color:
                        //                 index == 0 ? Colors.white : Colors.grey,
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   }),
                        // ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(
                            //   "ขั้นที่ 1: ",
                            //   style: fontHeader4.copyWith(
                            //     color: ColorResources.colorCaribbean,
                            //   ),
                            // ),
                            Text(
                              "ข้อมูลพื้นฐาน",
                              style: fontHeader5.copyWith(
                                color: ColorResources.colorCharcoal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "ข้อมูลส่วนตัว",
                        style: fontHeader5.copyWith(
                          color: ColorResources.colorCharcoal,
                        ),
                      ),
                      Text(
                        "*",
                        style: fontHeader5.copyWith(
                          color: ColorResources.colorCaribbean,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  // Upload profile
                  Image.asset(ImageResource.emsumeSection, height: 372),

                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration("คำนำหน้าชื่อ*"),
                    style: fontBody.copyWith(
                      color: ColorResources.colorCharcoal,
                    ), // สีของข้อความที่เลือก
                    dropdownColor: Colors.white, // สีพื้นหลังของ dropdown menu
                    isExpanded: false, // ให้ dropdown กินความกว้างเต็ม
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: ColorResources.colorFlint,
                    ), // สีของลูกศร
                    items:
                        ["นาย", "นางสาว", "นาง"]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: fontBody.copyWith(
                                    color: ColorResources.colorCharcoal,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (val) => setState(() => _selectedTitle = val),
                  ),

                  const SizedBox(height: 12),
                  TextFormField(decoration: _inputDecoration("ชื่อภาษาไทย*")),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: _inputDecoration("นามสกุลภาษาไทย*"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    initialValue: "Winittra",

                    decoration: _inputDecoration("ชื่อภาษาอังกฤษ*"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    initialValue: "Saengsroy",

                    decoration: _inputDecoration("นามสกุลภาษาอังกฤษ*"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: _inputDecoration("ชื่อเล่นภาษาไทย"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(decoration: _inputDecoration("ชื่อเล่นอังกฤษ")),
                  const SizedBox(height: 12),
                  TextFormField(
                    initialValue: "28 March 1996",
                    decoration: _inputDecoration("วันเกิด*"),
                    readOnly: true,
                    onTap: () {
                      // TODO: Date Picker
                    },
                  ),

                  const SizedBox(height: 12),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: RadioListTile<String>(
                  //         value: "ชาย",
                  //         groupValue: _gender,
                  //         title:  Text("ชาย",style: fontBody.copyWith(color: ColorResources.colorFlint),),
                  //         onChanged: (val) => setState(() => _gender = val),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: RadioListTile<String>(
                  //         value: "หญิง",
                  //         groupValue: _gender,
                  //         title:  Text("หญิง",style: fontBody.copyWith(color: ColorResources.colorFlint),),
                  //         onChanged: (val) => setState(() => _gender = val),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: RadioListTile<String>(
                  //         value: "อื่นๆ",
                  //         groupValue: _gender,
                  //         title:  Text("อื่นๆ",style:fontBody.copyWith(color: ColorResources.colorFlint),),
                  //         onChanged: (val) => setState(() => _gender = val),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: _inputDecoration("เลขประจำตัวประชาชน*"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    initialValue: "(+66)828983543",
                    decoration: _inputDecoration("โทรศัพท์*"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    initialValue: "Winittra .works@gmail .com",
                    decoration: _inputDecoration("อีเมล*"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: _inputDecoration("ที่อยู่ปัจจุบัน*"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(decoration: _inputDecoration("แขวง/ตำบล*")),
                  const SizedBox(height: 12),
                  TextFormField(decoration: _inputDecoration("เขต/อำเภอ*")),
                  const SizedBox(height: 12),
                  TextFormField(decoration: _inputDecoration("จังหวัด*")),
                  const SizedBox(height: 12),
                  TextFormField(decoration: _inputDecoration("รหัสไปรษณีย์*")),

                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: ColorResources.colorWhite,
                            disabledForegroundColor:
                                ColorResources.colorSoftCloud,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                6,
                              ), // มุมโค้ง 6
                            ),
                          ),
                          child: Text(
                            "ยกเลิก",
                            style: fontTitleStrong.copyWith(
                              color: ColorResources.colorSilver,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuestionnaireScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorResources.colorCaribbean,
                            disabledForegroundColor:
                                ColorResources.colorCaribbean,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                6,
                              ), // มุมโค้ง 6
                            ),
                          ),
                          child: Text(
                            "ถัดไป",
                            style: fontTitleStrong.copyWith(
                              color: ColorResources.colorWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: fontBody.copyWith(color: ColorResources.colorFlint),
      hintStyle: fontBody.copyWith(color: ColorResources.colorFlint),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    );
  }
}
