import 'package:equatable/equatable.dart';

class JobModel extends Equatable {
  final String id; // positionId
  final String title; // positionName
  final String titleEn; // positionName_EN
  final CompanyInfo company;
  final AISkillMatch aiSkillMatch;
  final EmploymentInfo employment;
  final LocationInfo location;
  final SalaryRange salaryRange;
  final String postedAgo;
  final DateTime dateCreated;
  final String? qualifications;
  final String? responsibility;
  final String? benefitDescription;
  final String logoURL;
  final String? coverURL;
  final String? aboutUs;
  final String? siteName;
  final String? siteURL;
  final int viewCount;
  final int applyCount;

  const JobModel({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.company,
    required this.aiSkillMatch,
    required this.employment,
    required this.location,
    required this.salaryRange,
    required this.postedAgo,
    required this.dateCreated,
    this.qualifications,
    this.responsibility,
    this.benefitDescription,
    required this.logoURL,
    this.coverURL,
    this.aboutUs,
    this.siteName,
    this.siteURL,
    this.viewCount = 0,
    this.applyCount = 0,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    // คำนวณเวลาที่โพสต์
    final dateCreated = DateTime.parse(json['dateCreated']);
    final now = DateTime.now();
    final difference = now.difference(dateCreated);

    String postedAgo;
    if (difference.inDays > 30) {
      postedAgo = '${(difference.inDays / 30).floor()}m ago';
    } else if (difference.inDays > 0) {
      postedAgo = '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      postedAgo = '${difference.inHours}h ago';
    } else {
      postedAgo = '${difference.inMinutes}m ago';
    }

    return JobModel(
      id: json['positionId']?.toString() ?? '',
      title: json['positionName'] ?? '',
      titleEn: json['positionName_EN'] ?? '',
      company: CompanyInfo(
        id: json['companyId']?.toString() ?? '',
        name: json['companyName'] ?? '',
        nameEn: json['companyName_EN'] ?? json['companyName'] ?? '',
        logoUrl: json['logoURL'],
        coverUrl: json['coverURL'],
        aboutUs: json['aboutUs'],
        themeColor: json['themeColorCode'],
      ),
      aiSkillMatch: AISkillMatch(
        score: (json['matchScore'] ?? 8) is int
            ? (json['matchScore'] ?? 8)
            : ((json['matchScore'] as double?) ?? 8.0).toInt(),
        matchedSkills: [],
      ),
      employment: EmploymentInfo(
        type: json['employmentTypeName_EN'] ?? 'Full-time',
        seniority: json['levelName_EN'] ?? 'Junior',
      ),
      location: LocationInfo(
        city: json['provinceName_EN'] ?? json['provinceName'] ?? '',
        workLocationName: json['workLocationName'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      ),
      salaryRange: SalaryRange(
        min: (json['minimumSalary'] ?? 0).toInt(),
        max: (json['maximumSalary'] ?? 0).toInt(),
        currency: 'THB',
        isHidden: json['isHideSalary'] ?? false,
      ),
      postedAgo: postedAgo,
      dateCreated: dateCreated,
      qualifications: json['qualifications'],
      responsibility: json['responsibility'],
      benefitDescription: json['benefitDescription'],
      logoURL: json['logoURL'],
      coverURL: json['coverURL'],
      aboutUs: json['aboutUs'],
      siteName: json['siteName'],
      siteURL: json['siteURL'],
      viewCount: json['viewCount'] ?? 0,
      applyCount: json['applyCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'positionId': id,
      'positionName': title,
      'positionName_EN': titleEn,
      'companyId': company.id,
      'companyName': company.name,
      'companyName_EN': company.nameEn,
      'matchScore': aiSkillMatch.score,
      'employmentTypeName_EN': employment.type,
      'levelName_EN': employment.seniority,
      'provinceName_EN': location.city,
      'minimumSalary': salaryRange.min,
      'maximumSalary': salaryRange.max,
      'isHideSalary': salaryRange.isHidden,
      'dateCreated': dateCreated.toIso8601String(),
      'qualifications': qualifications,
      'responsibility': responsibility,
      'benefitDescription': benefitDescription,
      'logoURL': logoURL,
      'coverURL': coverURL,
      'aboutUs': aboutUs,
      'siteName': siteName,
      'siteURL': siteURL,
      'viewCount': viewCount,
      'applyCount': applyCount,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    titleEn,
    company,
    aiSkillMatch,
    employment,
    location,
    salaryRange,
    postedAgo,
    dateCreated,
    qualifications,
    responsibility,
    benefitDescription,
    logoURL,
    coverURL,
    aboutUs,
    siteName,
    siteURL,
    viewCount,
    applyCount,
  ];
}

// Supporting classes
class CompanyInfo extends Equatable {
  final String id;
  final String name;
  final String nameEn;
  final String? logoUrl;
  final String? coverUrl;
  final String? aboutUs;
  final String? themeColor;

  const CompanyInfo({
    required this.id,
    required this.name,
    required this.nameEn,
    this.logoUrl,
    this.coverUrl,
    this.aboutUs,
    this.themeColor,
  });

  @override
  List<Object?> get props => [id, name, nameEn, logoUrl, coverUrl, aboutUs, themeColor];
}

class AISkillMatch extends Equatable {
  final int score; // 0-10
  final List<String> matchedSkills;

  const AISkillMatch({
    required this.score,
    required this.matchedSkills,
  });

  @override
  List<Object?> get props => [score, matchedSkills];
}

class EmploymentInfo extends Equatable {
  final String type; // Full-time, Part-time, etc.
  final String seniority; // Junior, Mid-level, Senior

  const EmploymentInfo({
    required this.type,
    required this.seniority,
  });

  @override
  List<Object?> get props => [type, seniority];
}

class LocationInfo extends Equatable {
  final String city;
  final String? workLocationName;
  final double? latitude;
  final double? longitude;

  const LocationInfo({
    required this.city,
    this.workLocationName,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [city, workLocationName, latitude, longitude];
}

class SalaryRange extends Equatable {
  final int min;
  final int max;
  final String currency;
  final bool isHidden;

  const SalaryRange({
    required this.min,
    required this.max,
    required this.currency,
    required this.isHidden,
  });

  @override
  List<Object?> get props => [min, max, currency, isHidden];
}