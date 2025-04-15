class Policy {
  final String id;
  final String title;
  final String description;
  final String region;
  final String category;
  final String targetAge;
  final String period;
  final String organization;
  final String eligibility;
  final String benefits;
  final String applicationMethod;
  final String requiredDocuments;
  final String status; // 'active', 'completed', 'upcoming'
  final double rating;
  final int reviewCount;
  final int participantCount;
  final int targetParticipants;
  final List<String> tags;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Policy({
    required this.id,
    required this.title,
    required this.description,
    required this.region,
    required this.category,
    required this.targetAge,
    required this.period,
    required this.organization,
    required this.eligibility,
    required this.benefits,
    required this.applicationMethod,
    required this.requiredDocuments,
    required this.status,
    required this.rating,
    required this.reviewCount,
    required this.participantCount,
    required this.targetParticipants,
    required this.tags,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Policy.fromJson(Map<String, dynamic> json) {
    return Policy(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      region: json['region'] as String,
      category: json['category'] as String,
      targetAge: json['targetAge'] as String,
      period: json['period'] as String,
      organization: json['organization'] as String,
      eligibility: json['eligibility'] as String,
      benefits: json['benefits'] as String,
      applicationMethod: json['applicationMethod'] as String,
      requiredDocuments: json['requiredDocuments'] as String,
      status: json['status'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      participantCount: json['participantCount'] as int,
      targetParticipants: json['targetParticipants'] as int,
      tags: List<String>.from(json['tags'] as List),
      imageUrl: json['imageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // CSV 파일에서 Policy 객체 생성
  factory Policy.fromCsv(Map<String, dynamic> csvRow) {
    return Policy(
      id: csvRow['id'] ?? '',
      title: csvRow['title'] ?? '',
      description: csvRow['description'] ?? '',
      region: csvRow['region'] ?? '',
      category: csvRow['category'] ?? '',
      targetAge: csvRow['targetAge'] ?? '',
      period: csvRow['period'] ?? '',
      organization: csvRow['organization'] ?? '',
      eligibility: csvRow['eligibility'] ?? '',
      benefits: csvRow['benefits'] ?? '',
      applicationMethod: csvRow['applicationMethod'] ?? '',
      requiredDocuments: csvRow['requiredDocuments'] ?? '',
      status: csvRow['status'] ?? 'active',
      rating: double.tryParse(csvRow['rating']?.toString() ?? '0.0') ?? 0.0,
      reviewCount: int.tryParse(csvRow['reviewCount']?.toString() ?? '0') ?? 0,
      participantCount: int.tryParse(csvRow['participantCount']?.toString() ?? '0') ?? 0,
      targetParticipants: int.tryParse(csvRow['targetParticipants']?.toString() ?? '0') ?? 0,
      tags: csvRow['tags']?.toString().split(',').map((e) => e.trim()).toList() ?? [],
      imageUrl: csvRow['imageUrl'] ?? '',
      createdAt: DateTime.tryParse(csvRow['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(csvRow['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'region': region,
      'category': category,
      'targetAge': targetAge,
      'period': period,
      'organization': organization,
      'eligibility': eligibility,
      'benefits': benefits,
      'applicationMethod': applicationMethod,
      'requiredDocuments': requiredDocuments,
      'status': status,
      'rating': rating,
      'reviewCount': reviewCount,
      'participantCount': participantCount,
      'targetParticipants': targetParticipants,
      'tags': tags,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // CSV 형식으로 변환
  Map<String, dynamic> toCsvMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'region': region,
      'category': category,
      'targetAge': targetAge,
      'period': period,
      'organization': organization,
      'eligibility': eligibility,
      'benefits': benefits,
      'applicationMethod': applicationMethod,
      'requiredDocuments': requiredDocuments,
      'status': status,
      'rating': rating.toString(),
      'reviewCount': reviewCount.toString(),
      'participantCount': participantCount.toString(),
      'targetParticipants': targetParticipants.toString(),
      'tags': tags.join(','),
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}