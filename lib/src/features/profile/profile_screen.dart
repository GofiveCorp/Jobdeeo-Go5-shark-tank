import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView( // เผื่อ scroll ได้
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFB2EBF2), Color(0xFFE1F5FE)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar + Name
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.grey,
                          // backgroundImage: AssetImage("assets/avatar.png"),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("วินิตรา แสงสร้อย", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Text("Mobile Developer, 2 yrs experience", style: TextStyle(color: Colors.teal)),
                            Text("Bangkok"),
                            Text("Winittra.works@gmail.com"),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Profile Strength + Jobs
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("80% Profile Strength"),
                                  Text("Update profile", style: TextStyle(color: Colors.teal)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: const [
                                  Text("1"),
                                  Text("งานที่สมัคร"),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 AI Suggestion Box
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Colors.pinkAccent, Colors.orangeAccent],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("✨ AI Suggestion", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("You have 85% Matches with Mobile Developer",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 8),
                    Text("To get 100%, Try to", style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 8),
                    Text("1. Improve your resume", style: TextStyle(color: Colors.white)),
                    Text("2. Add more skills", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Skill / Resume Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Text("Skill", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                    SizedBox(width: 16),
                    Text("Resume"),
                    SizedBox(width: 16),
                    Text("Certifications"),
                    SizedBox(width: 16),
                    Text("Experience"),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 🔹 Skill tags
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: Text("Swift สูง")),
                    Chip(label: Text("Kotlin กลาง")),
                    Chip(label: Text("Firebase เบื้องต้น")),
                    Chip(label: Text("+ Flutter กลาง"), backgroundColor: Colors.pink.shade100),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Resume
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                    title: const Text("Portfolio.pdf"),
                    subtitle: const Text("05/04/2023"),
                    trailing: const Text("Default"),
                  ),
                ),
              ),

              const SizedBox(height: 80), // เผื่อ space ข้างล่าง
            ],
          ),
        ),

      ),
    );
  }
}
