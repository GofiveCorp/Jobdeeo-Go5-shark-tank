// class Profile {
//   final String name;
//   final String role;
//   final String experience;
//   final String location;
//   final String email;
//   final int profileStrength;
//   final int appliedJobs;
//   final AiSuggestion aiSuggestion;
//   final List<Skill> skills;
//   final Resume resume;
//
//   Profile({
//     required this.name,
//     required this.role,
//     required this.experience,
//     required this.location,
//     required this.email,
//     required this.profileStrength,
//     required this.appliedJobs,
//     required this.aiSuggestion,
//     required this.skills,
//     required this.resume,
//   });
//
//   factory Profile.fromJson(Map<String, dynamic> json) {
//     return Profile(
//       name: json['name'],
//       role: json['role'],
//       experience: json['experience'],
//       location: json['location'],
//       email: json['email'],
//       profileStrength: json['profileStrength'],
//       appliedJobs: json['appliedJobs'],
//       aiSuggestion: AiSuggestion.fromJson(json['aiSuggestion']),
//       skills: (json['skills'] as List)
//           .map((e) => Skill.fromJson(e))
//           .toList(),
//       resume: Resume.fromJson(json['resume']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "name": name,
//       "role": role,
//       "experience": experience,
//       "location": location,
//       "email": email,
//       "profileStrength": profileStrength,
//       "appliedJobs": appliedJobs,
//       "aiSuggestion": aiSuggestion.toJson(),
//       "skills": skills.map((e) => e.toJson()).toList(),
//       "resume": resume.toJson(),
//     };
//   }
// }
//
// class AiSuggestion {
//   final int match;
//   final List<String> improvements;
//
//   AiSuggestion({required this.match, required this.improvements});
//
//   factory AiSuggestion.fromJson(Map<String, dynamic> json) {
//     return AiSuggestion(
//       match: json['match'],
//       improvements: List<String>.from(json['improvements']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "match": match,
//       "improvements": improvements,
//     };
//   }
// }
//
// class Skill {
//   final String name;
//   final String level;
//
//   Skill({required this.name, required this.level});
//
//   factory Skill.fromJson(Map<String, dynamic> json) {
//     return Skill(
//       name: json['name'],
//       level: json['level'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "name": name,
//       "level": level,
//     };
//   }
// }
//
// class Resume {
//   final String fileName;
//   final String date;
//
//   Resume({required this.fileName, required this.date});
//
//   factory Resume.fromJson(Map<String, dynamic> json) {
//     return Resume(
//       fileName: json['fileName'],
//       date: json['date'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "fileName": fileName,
//       "date": date,
//     };
//   }
// }


class Profile {
  final String name;
  final String role;
  final String experience;
  final String location;
  final String email;
  final int profileStrength;
  final int appliedJobs;
  final AiSuggestion aiSuggestion;
  final List<Skill> skills;
  final Resume resume;

  Profile({
    required this.name,
    required this.role,
    required this.experience,
    required this.location,
    required this.email,
    required this.profileStrength,
    required this.appliedJobs,
    required this.aiSuggestion,
    required this.skills,
    required this.resume,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      role: json['role'],
      experience: json['experience'],
      location: json['location'],
      email: json['email'],
      profileStrength: json['profileStrength'],
      appliedJobs: json['appliedJobs'],
      aiSuggestion: AiSuggestion.fromJson(json['aiSuggestion']),
      skills: (json['skills'] as List)
          .map((e) => Skill.fromJson(e))
          .toList(),
      resume: Resume.fromJson(json['resume']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "role": role,
      "experience": experience,
      "location": location,
      "email": email,
      "profileStrength": profileStrength,
      "appliedJobs": appliedJobs,
      "aiSuggestion": aiSuggestion.toJson(),
      "skills": skills.map((e) => e.toJson()).toList(),
      "resume": resume.toJson(),
    };
  }

  /// 🟢 Mock data
  static Profile mock() {
    return Profile(
      name: "วินิตรา แสงสร้อย",
      role: "Mobile Developer",
      experience: "2 yrs experience",
      location: "Bangkok",
      email: "Winittra.works@gmail.com",
      profileStrength: 80,
      appliedJobs: 1,
      aiSuggestion: AiSuggestion(
        match: 85,
        improvements: ["Improve your resume", "Add more skills"],
      ),
      skills: [
        Skill(name: "Swift", level: "สูง"),
        Skill(name: "Kotlin", level: "กลาง"),
        Skill(name: "Firebase", level: "เบื้องต้น"),
        Skill(name: "Flutter", level: "กลาง"),
      ],
      resume: Resume(
        fileName: "Portfolio.pdf",
        date: "05/04/2023",
      ),
    );
  }
}

class AiSuggestion {
  final int match;
  final List<String> improvements;

  AiSuggestion({required this.match, required this.improvements});

  factory AiSuggestion.fromJson(Map<String, dynamic> json) {
    return AiSuggestion(
      match: json['match'],
      improvements: List<String>.from(json['improvements']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "match": match,
      "improvements": improvements,
    };
  }
}

class Skill {
  final String name;
  final String level;

  Skill({required this.name, required this.level});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "level": level,
    };
  }
}

class Resume {
  final String fileName;
  final String date;

  Resume({required this.fileName, required this.date});

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      fileName: json['fileName'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fileName": fileName,
      "date": date,
    };
  }
}
