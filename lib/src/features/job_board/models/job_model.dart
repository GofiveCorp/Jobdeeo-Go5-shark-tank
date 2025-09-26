import 'package:equatable/equatable.dart';

class JobModel extends Equatable {
  final String id;
  final String title;
  final String companyName;
  final String companyLogo;
  final int matchPercentage;
  final String level;
  final String workType;
  final String location;
  final String salaryRange;
  final DateTime postedAt;

  const JobModel({
    required this.id,
    required this.title,
    required this.companyName,
    required this.companyLogo,
    required this.matchPercentage,
    required this.level,
    required this.workType,
    required this.location,
    required this.salaryRange,
    required this.postedAt,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      title: json['title'],
      companyName: json['companyName'],
      companyLogo: json['companyLogo'],
      matchPercentage: json['matchPercentage'],
      level: json['level'],
      workType: json['workType'],
      location: json['location'],
      salaryRange: json['salaryRange'],
      postedAt: DateTime.parse(json['postedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'companyName': companyName,
      'companyLogo': companyLogo,
      'matchPercentage': matchPercentage,
      'level': level,
      'workType': workType,
      'location': location,
      'salaryRange': salaryRange,
      'postedAt': postedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    companyName,
    companyLogo,
    matchPercentage,
    level,
    workType,
    location,
    salaryRange,
    postedAt,
  ];
}