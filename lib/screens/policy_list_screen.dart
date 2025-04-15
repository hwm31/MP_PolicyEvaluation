import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_job_policy_app/config/routes.dart';
import 'package:youth_job_policy_app/providers/policy_provider.dart';

import '../widgets/policy_card.dart';

class PolicyListScreen extends StatefulWidget {
  final String regionId;
  final String category;

  const PolicyListScreen({
    super.key,
    required this.regionId,
    required this.category,
  });

  @override
  State<PolicyListScreen> createState() => _PolicyListScreenState();
}

class _PolicyListScreenState extends State<PolicyListScreen> {
  String _selectedCategory = '전체';
  List<String> categories = ['전체', '창업', '취업', '교육'];

  @override
  void initState() {
    super.initState();
    if (widget.category.isNotEmpty) {
      _selectedCategory = widget.category;
    }

    // 정책 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final policyProvider = Provider.of<PolicyProvider>(context, listen: false);
      policyProvider.fetchPolicies(
        region: widget.regionId.isNotEmpty ? widget.regionId : null,
        category: _selectedCategory != '전체' ? _selectedCategory : null,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.regionId.isNotEmpty
            ? '${widget.regionId} 일자리 정책'
            : '맞춤 일자리 정책 추천'),
      ),
      body: Column(
        children: [
          // 카테고리 필터
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: category, // Text 위젯 대신 String 전달
                      selected: _selectedCategory == category,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });

                          // 필터 변경시 데이터 다시 로드
                          final policyProvider = Provider.of<PolicyProvider>(context, listen: false);
                          policyProvider.fetchPolicies(
                            region: widget.regionId.isNotEmpty ? widget.regionId : null,
                            category: _selectedCategory != '전체' ? _selectedCategory : null,
                          );
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // 정책 목록
          Expanded(
            child: Consumer<PolicyProvider>(
              builder: (context, policyProvider, child) {
                if (policyProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (policyProvider.error.isNotEmpty) {
                  return Center(
                    child: Text(
                      '데이터를 불러오는데 실패했습니다: ${policyProvider.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (policyProvider.policies.isEmpty) {
                  return const Center(
                    child: Text('정책이 없습니다. 다른 필터를 선택해보세요.'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: policyProvider.policies.length,
                  itemBuilder: (context, index) {
                    final policy = policyProvider.policies[index];
                    return PolicyCard(
                      policy: policy,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.policyDetail,
                          arguments: policy.id,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 임시 FilterChip 위젯 (widgets/filter_chips.dart 파일로 이동해야 함)
class FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function(bool) onSelected;

  const FilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(!selected),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? Theme.of(context).primaryColor : Colors.grey,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}