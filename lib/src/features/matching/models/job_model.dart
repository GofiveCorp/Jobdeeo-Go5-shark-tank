import 'package:equatable/equatable.dart';

class JobModel extends Equatable {
  final String id;
  final String title;
  final CompanyModel company;
  final String postedAgo;
  final SkillMatchModel aiSkillMatch;
  final List<SkillModel> skills;
  final EmploymentModel employment;
  final LocationModel location;
  final SalaryRangeModel salaryRange;
  final String overviewTitle;
  final String overview;
  final String requirementsTitle;
  final List<String> requirements;
  final String aboutCompany;
  final String contactsTitle;
  final List<BranchModel> branches;
  final MapModel map;
  final bool isBookmarked;
  final bool isApplied;
  final bool actionFromCompany;

  const JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.postedAgo,
    required this.aiSkillMatch,
    required this.skills,
    required this.employment,
    required this.location,
    required this.salaryRange,
    required this.overviewTitle,
    required this.overview,
    required this.requirementsTitle,
    required this.requirements,
    required this.aboutCompany,
    required this.contactsTitle,
    required this.branches,
    required this.map,
    required this.isBookmarked,
    required this.isApplied,
    required this.actionFromCompany,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      company: CompanyModel.fromJson(json['company'] ?? {}),
      postedAgo: json['posted_ago'] ?? '',
      aiSkillMatch: SkillMatchModel.fromJson(json['ai_skill_match'] ?? {}),
      skills: (json['skills'] as List?)
          ?.map((skill) => SkillModel.fromJson(skill))
          .toList() ??
          [],
      employment: EmploymentModel.fromJson(json['employment'] ?? {}),
      location: LocationModel.fromJson(json['location'] ?? {}),
      salaryRange: SalaryRangeModel.fromJson(json['salary_range'] ?? {}),
      overviewTitle: json['overview_title'] ?? '',
      overview: json['overview'] ?? '',
      requirementsTitle: json['requirements_title'] ?? '',
      requirements: (json['requirements'] as List?)?.cast<String>() ?? [],
      aboutCompany: json['about_company'] ?? '',
      contactsTitle: json['contacts_title'] ?? '',
      branches: (json['branches'] as List?)
          ?.map((branch) => BranchModel.fromJson(branch))
          .toList() ??
          [],
      map: MapModel.fromJson(json['map'] ?? {}),
      isBookmarked: json['is_bookmarked'] ?? false,
      isApplied: json['is_applied'] ?? false,
      actionFromCompany: json['actionFromCompany'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company.toJson(),
      'posted_ago': postedAgo,
      'ai_skill_match': aiSkillMatch.toJson(),
      'skills': skills.map((skill) => skill.toJson()).toList(),
      'employment': employment.toJson(),
      'location': location.toJson(),
      'salary_range': salaryRange.toJson(),
      'overview_title': overviewTitle,
      'overview': overview,
      'requirements_title': requirementsTitle,
      'requirements': requirements,
      'about_company': aboutCompany,
      'contacts_title': contactsTitle,
      'branches': branches.map((branch) => branch.toJson()).toList(),
      'map': map.toJson(),
      'is_bookmarked': isBookmarked,
      'is_applied': isApplied,
      'actionFromCompany': actionFromCompany,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    company,
    postedAgo,
    aiSkillMatch,
    skills,
    employment,
    location,
    salaryRange,
    overviewTitle,
    overview,
    requirementsTitle,
    requirements,
    aboutCompany,
    contactsTitle,
    branches,
    map,
    isBookmarked,
    isApplied,
    actionFromCompany,
  ];
}

class CompanyModel extends Equatable {
  final String id;
  final String name;
  final String logoUrl;

  const CompanyModel({
    required this.id,
    required this.name,
    required this.logoUrl,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      logoUrl: json['logo_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo_url': logoUrl,
    };
  }

  @override
  List<Object?> get props => [id, name, logoUrl];
}

class SkillMatchModel extends Equatable {
  final int score;
  final int max;
  final String label;

  const SkillMatchModel({
    required this.score,
    required this.max,
    required this.label,
  });

  factory SkillMatchModel.fromJson(Map<String, dynamic> json) {
    return SkillMatchModel(
      score: json['score'] ?? 0,
      max: json['max'] ?? 10,
      label: json['label'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'max': max,
      'label': label,
    };
  }

  int get percentage => max > 0 ? ((score / max) * 100).round() : 0;

  @override
  List<Object?> get props => [score, max, label];
}

class SkillModel extends Equatable {
  final String name;
  final String level;

  const SkillModel({
    required this.name,
    required this.level,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      name: json['name'] ?? '',
      level: json['level'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
    };
  }

  @override
  List<Object?> get props => [name, level];
}

class EmploymentModel extends Equatable {
  final String seniority;
  final String type;

  const EmploymentModel({
    required this.seniority,
    required this.type,
  });

  factory EmploymentModel.fromJson(Map<String, dynamic> json) {
    return EmploymentModel(
      seniority: json['seniority'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seniority': seniority,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [seniority, type];
}

class LocationModel extends Equatable {
  final String city;
  final String country;

  const LocationModel({
    required this.city,
    required this.country,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      city: json['city'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
    };
  }

  @override
  List<Object?> get props => [city, country];
}

class SalaryRangeModel extends Equatable {
  final String currency;
  final int min;
  final int max;

  const SalaryRangeModel({
    required this.currency,
    required this.min,
    required this.max,
  });

  factory SalaryRangeModel.fromJson(Map<String, dynamic> json) {
    return SalaryRangeModel(
      currency: json['currency'] ?? 'THB',
      min: json['min'] ?? 0,
      max: json['max'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'min': min,
      'max': max,
    };
  }

  String get formattedRange => '$currency ${_formatNumber(min)} - ${_formatNumber(max)}';

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }

  @override
  List<Object?> get props => [currency, min, max];
}

class BranchModel extends Equatable {
  final String name;
  final String address;

  const BranchModel({
    required this.name,
    required this.address,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
    };
  }

  @override
  List<Object?> get props => [name, address];
}

class MapModel extends Equatable {
  final String label;
  final double latitude;
  final double longitude;
  final String googleMapsEmbedUrl;

  const MapModel({
    required this.label,
    required this.latitude,
    required this.longitude,
    required this.googleMapsEmbedUrl,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
      label: json['label'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      googleMapsEmbedUrl: json['google_maps_embed_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'latitude': latitude,
      'longitude': longitude,
      'google_maps_embed_url': googleMapsEmbedUrl,
    };
  }

  @override
  List<Object?> get props => [label, latitude, longitude, googleMapsEmbedUrl];
}