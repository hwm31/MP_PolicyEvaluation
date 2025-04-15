// widgets/policy_card.dart
import 'package:flutter/material.dart';
import 'package:youth_job_policy_app/models/policy.dart';

class PolicyCard extends StatelessWidget {
  final Policy policy;
  final VoidCallback onTap;

  const PolicyCard({
    super.key,
    required this.policy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 정책 카테고리 표시 (색상 구분)
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 16,
                    decoration: BoxDecoration(
                      color: _getCategoryColor(policy.category),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    policy.category,
                    style: TextStyle(
                      color: _getCategoryColor(policy.category),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        policy.rating.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 정책 제목
              Text(
                policy.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),

              // 정책 간단 설명
              Text(
                policy.benefits,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // 정책 대상
              Text(
                "대상: ${policy.eligibility}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),

              // 태그 표시
              Wrap(
                spacing: 8,
                children: policy.tags.map((tag) {
                  return Chip(
                    label: Text(
                      '#$tag',
                      style: const TextStyle(fontSize: 10),
                    ),
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case '창업':
        return Colors.green;
      case '취업':
        return Colors.blue;
      case '교육':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}