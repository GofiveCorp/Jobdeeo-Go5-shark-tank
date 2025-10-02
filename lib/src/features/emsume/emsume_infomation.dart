import 'package:flutter/material.dart';
import 'package:jobdeeo/src/core/base/color_resource.dart';
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
    return Scaffold(
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
                style: fontBody.copyWith(color: ColorResources.colorPorpoise),
              ),
            ),
            SizedBox(height: 24),
                // Step progress
                Container(
                  color: ColorResources.backgroundColor,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == 0 ? ColorResources.colorFlame : Colors.white,
                              border: Border.all(color: index == 0 ? ColorResources.colorFlame : ColorResources.colorFlint),
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: fontTitleStrong.copyWith(
                                  color: index == 0 ? Colors.white : Colors.grey,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                                            const SizedBox(height: 16),

                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("ขั้นที่ 1: ",
                              style: fontHeader4.copyWith(color:ColorResources.colorCaribbean)),
                           Text("เริ่มต้นที่ข้อมูลพื้นฐาน",
                              style: fontHeader4.copyWith(color: ColorResources.colorCharcoal)),
                         ],
                       ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Text("ข้อมูลส่วนตัว",
                        style: fontHeader5.copyWith(color: ColorResources.colorCharcoal)),
                          Text("*",
                    style: fontHeader5.copyWith(color: ColorResources.colorCaribbean)),
                   ],
                 ),
                  

                const SizedBox(height: 12),
                // Upload profile
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.person_outline, size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text("อัปโหลดรูปโปรไฟล์*"),
                      Text("ขนาดไม่ควรเกิน 20 MB",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                // Upload resume
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.insert_drive_file_outlined,
                          size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text("อัปโหลดเรซูเม่หรือซีวี*"),
                      Text(".pdf, .png, .jpg, .jpeg | ไม่เกิน 20 MB",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    ChoiceChip(
                      label: const Text("คนไทย"),
                      selected: true,
                      onSelected: (_) {},
                      selectedColor: Colors.teal.shade100,
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text("ชาวต่างชาติ"),
                      selected: false,
                      onSelected: (_) {},
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration("คำนำหน้าชื่อ*"),
                  items: ["นาย", "นางสาว", "นาง"]
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedTitle = val),
                ),

                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("ชื่อภาษาไทย*")),
                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("นามสกุลภาษาไทย*")),
                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("ชื่อภาษาอังกฤษ*")),
                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("นามสกุลภาษาอังกฤษ*")),
                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("ชื่อเล่นภาษาไทย")),
                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("ชื่อเล่นอังกฤษ")),
                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("วันเกิด*"),
                    readOnly: true,
                    onTap: () {
                      // TODO: Date Picker
                    }),

                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        value: "ชาย",
                        groupValue: _gender,
                        title: const Text("ชาย"),
                        onChanged: (val) => setState(() => _gender = val),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        value: "หญิง",
                        groupValue: _gender,
                        title: const Text("หญิง"),
                        onChanged: (val) => setState(() => _gender = val),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        value: "อื่นๆ",
                        groupValue: _gender,
                        title: const Text("อื่นๆ"),
                        onChanged: (val) => setState(() => _gender = val),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("เลขประจำตัวประชาชน*")),
                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("โทรศัพท์*")),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: "best.p@gmail.com",
                  decoration: _inputDecoration("อีเมล*"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("ที่อยู่ปัจจุบัน*")),
                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("แขวง/ตำบล*")),
                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("เขต/อำเภอ*")),
                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("จังหวัด*")),
                const SizedBox(height: 12),
                TextFormField(
                    decoration: _inputDecoration("รหัสไปรษณีย์*")),

                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text("ยกเลิก"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionnaireScreen(),
                          ),
                        );},
                        child: const Text("ถัดไป"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}
