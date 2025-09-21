import 'package:equatable/equatable.dart';

class CompanyModel extends Equatable {
  final String id;
  final String name;
  final String logo;
  final String image;
  final String description;
  final String industry;
  final int employeeCount;
  final String website;

  const CompanyModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.image,
    required this.description,
    required this.industry,
    required this.employeeCount,
    required this.website,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      image: json['image'],
      description: json['description'],
      industry: json['industry'],
      employeeCount: json['employeeCount'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'image': image,
      'description': description,
      'industry': industry,
      'employeeCount': employeeCount,
      'website': website,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    logo,
    image,
    description,
    industry,
    employeeCount,
    website,
  ];
}