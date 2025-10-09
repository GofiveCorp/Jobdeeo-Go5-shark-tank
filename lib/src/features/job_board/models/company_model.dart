import 'package:equatable/equatable.dart';

class CompanyModel extends Equatable {
  final String companyId;
  final String name;
  final String siteName;
  final String description;
  final String coverURL;
  final String logoURL;
  final String benefitDescription;
  final String aboutUs;
  final double? latitude;
  final double? longitude;

  const CompanyModel({
    required this.companyId,
    required this.name,
    required this.siteName,
    required this.description,
    required this.coverURL,
    required this.logoURL,
    required this.benefitDescription,
    required this.aboutUs,
    this.latitude,
    this.longitude,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      companyId: json['companyId']?.toString() ?? '',
      name: json['name'] ?? '',
      siteName: json['siteName'] ?? '',
      description: json['description'] ?? '',
      coverURL: json['coverURL'] ?? '',
      logoURL: json['logoURL'] ?? '',
      benefitDescription: json['benefitDescription'] ?? '',
      aboutUs: json['aboutUs'] ?? '',
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
      'name': name,
      'siteName': siteName,
      'description': description,
      'coverURL': coverURL,
      'logoURL': logoURL,
      'benefitDescription': benefitDescription,
      'aboutUs': aboutUs,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Helper method to strip HTML tags
  String _stripHtml(String htmlString) {
    if (htmlString.isEmpty) return '';

    // Remove HTML tags
    String text = htmlString.replaceAll(RegExp(r'<[^>]*>'), '');

    // Decode HTML entities
    text = text
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&nbsp;', ' ')
        .replaceAll('\n', ' ')
        .replaceAll(RegExp(r'\s+'), ' '); // Replace multiple spaces with single space

    return text.trim();
  }

// Getter for plain text description
  String get plainDescription => _stripHtml(description);

// Getter for plain text about us
  String get plainAboutUs => _stripHtml(aboutUs);

  @override
  List<Object?> get props => [
    companyId,
    name,
    siteName,
    description,
    coverURL,
    logoURL,
    benefitDescription,
    aboutUs,
    latitude,
    longitude,
  ];
}