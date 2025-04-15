import 'package:flutter/material.dart';
import 'package:youth_job_policy_app/config/routes.dart';
import 'package:youth_job_policy_app/models/policy.dart';

class PolicyDetailScreen extends StatefulWidget {
  final String policyId;

  const PolicyDetailScreen({
    super.key,
    required this.policyId,
  });

  @override
  State<PolicyDetailScreen> createState() => _PolicyDetailScreenState();
}

class _PolicyDetailScreenState extends State<PolicyDetailScreen> {
  bool _isLoading = true;
  late Policy _policy;

  @override
  void initState() {
    super.initState();
    _loadPolicyDetails();
  }

  Future<void> _loadPolicyDetails() async {
    // 실제로는 Firebase나 API에서 정책 상세 정보를 가져옵니다
    await Future.delayed(const Duration(seconds: 1));

    // 임시 데이터
    _policy = Policy(
      id: widget.policyId,
      title: 'IT 인재 양성 프로그램',
      description: '청년 IT 개발자 양성을 위한 6개월 교육 프로그램입니다. 교육 기간 동안 월 80만원의 지원금이 제공되며, 수료 후 취업 연계를 지원합니다.',
      region: '서울특별시',
      category: '교육',
      targetAge: '만 19세 ~ 34세',
      period: '2025.01.01 ~ 2025.06.30',
      organization: '서울특별시청',
      eligibility: '서울시 거주 청년, 미취업자',
      benefits: '월 80만원 교육 지원금, 교육 프로그램 무료 제공, 취업 연계 지원',
      applicationMethod: '서울시 청년정책 홈페이지에서 온라인 접수',
      requiredDocuments: '신분증, 주민등록등본, 졸업증명서',
      status: 'active',
      rating: 4.8,
      reviewCount: 128,
      participantCount: 520,
      targetParticipants: 600,
      tags: ['IT교육', '취업지원', '월지원금'],
      imageUrl: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('정책 상세 정보'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _policy.title,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),

            // 정책 기본 정보
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('지역', _policy.region),
                    _buildInfoRow('대상', _policy.targetAge),
                    _buildInfoRow('기간', _policy.period),
                    _buildInfoRow('주관', _policy.organization),
                    const SizedBox(height: 8),
                    Text(
                      _policy.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 태그
            Wrap(
              spacing: 8,
              children: _policy.tags.map((tag) {
                return Chip(
                  label: Text('#$tag'),
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // 상세 정보
            Text(
              '지원 내용',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(_policy.benefits),
            const SizedBox(height: 16),

            Text(
              '지원 자격',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(_policy.eligibility),
            const SizedBox(height: 16),

            Text(
              '신청 방법',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(_policy.applicationMethod),
            const SizedBox(height: 16),

            Text(
              '필요 서류',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(_policy.requiredDocuments),
            const SizedBox(height: 24),

            // 평점 및 리뷰 요약
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '평점 및 리뷰',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              '${_policy.rating} (${_policy.reviewCount}건)',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.policyReview,
                          arguments: _policy.id,
                        );
                      },
                      child: const Text('리뷰 작성하기'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 참여 현황
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '참여 현황',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _policy.participantCount / _policy.targetParticipants,
                      backgroundColor: Colors.grey[300],
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_policy.participantCount}명 / ${_policy.targetParticipants}명 (${(_policy.participantCount / _policy.targetParticipants * 100).toStringAsFixed(1)}%)',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}