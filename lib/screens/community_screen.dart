import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_job_policy_app/config/routes.dart';
import 'package:youth_job_policy_app/providers/auth_provider.dart';
import 'package:youth_job_policy_app/widgets/filter_chips.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String _selectedCategory = '전체';
  List<String> categories = ['전체', '질문', '후기', '정보'];
  int _currentIndex = 3; // 커뮤니티 탭 인덱스

  // 임시 게시글 데이터
  final List<Map<String, dynamic>> _posts = [
    {
      'id': 'post1',
      'title': 'IT 인재 양성 프로그램 후기 공유합니다',
      'author': '김청년',
      'category': '후기',
      'createdAt': DateTime.now().subtract(const Duration(days: 2)),
      'views': 128,
      'comments': 24,
      'content': '6개월 과정 끝나고 취업까지 성공했어요! 노하우 공유...',
      'isMP': false,
    },
    {
      'id': 'post2',
      'title': '[국회의원] 청년 정책 간담회 안내',
      'author': '이의원',
      'category': '정보',
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
      'views': 356,
      'comments': 42,
      'content': '다음 주 화요일 온라인 간담회를 개최합니다. 많은 참여...',
      'isMP': true,
    },
    {
      'id': 'post3',
      'title': '창업 지원금 신청 자격 질문드려요',
      'author': '박창업',
      'category': '질문',
      'createdAt': DateTime.now().subtract(const Duration(hours: 5)),
      'views': 78,
      'comments': 8,
      'content': '사업자등록을 하지 않은 상태에서도 신청 가능한가요?',
      'isMP': false,
    },
    {
      'id': 'post4',
      'title': '서울시 청년 일자리 카페 위치 정보',
      'author': '정정보',
      'category': '정보',
      'createdAt': DateTime.now().subtract(const Duration(hours: 12)),
      'views': 201,
      'comments': 15,
      'content': '서울시 각 지역별 청년 일자리 카페 위치 정보를 공유합니다.',
      'isMP': false,
    },
    {
      'id': 'post5',
      'title': 'IT 중소기업 취업 프로그램 경험담',
      'author': '최취업',
      'category': '후기',
      'createdAt': DateTime.now().subtract(const Duration(days: 4)),
      'views': 167,
      'comments': 31,
      'content': '이 프로그램으로 중소기업에 취업했는데 장단점을 공유합니다.',
      'isMP': false,
    },
  ];

  List<Map<String, dynamic>> get filteredPosts {
    if (_selectedCategory == '전체') {
      return _posts;
    } else {
      return _posts.where((post) => post['category'] == _selectedCategory).toList();
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case '질문':
        return Colors.blue;
      case '후기':
        return Colors.green;
      case '정보':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }

  void _showNewPostDialog(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String postCategory = '질문';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('새 글 작성'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('카테고리'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: ['질문', '후기', '정보'].map((category) {
                        return ChoiceChip(
                          label: Text(category),
                          selected: postCategory == category,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                postCategory = category;
                              });
                            }
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: '제목',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: contentController,
                      decoration: const InputDecoration(
                        labelText: '내용',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 게시글 저장 로직
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('게시글이 등록되었습니다')),
                    );
                  },
                  child: const Text('등록'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPostItem(BuildContext context, Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.communityDetail,
            arguments: post['id'],
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(post['category']),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      post['category'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  if (post['isMP'])
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '정책담당자',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const Spacer(),
                  Text(
                    _formatDate(post['createdAt']),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                post['title'],
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                post['content'],
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      post['author'].substring(0, 1),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    post['author'],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  const Icon(Icons.remove_red_eye, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${post['views']}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.comment, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${post['comments']}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('청년 일자리 커뮤니티'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // 검색 기능 구현
            },
          ),
        ],
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
                    child: CustomFilterChip(
                      label: category,
                      selected: _selectedCategory == category,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // 새 글 작성 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // 새 글 작성 화면으로 이동
                  _showNewPostDialog(context);
                },
                icon: const Icon(Icons.edit),
                label: const Text('새 글 작성하기'),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // 게시글 목록
          Expanded(
            child: ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                return _buildPostItem(context, post);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.map);
          } else if (index == 1) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.profile);
          } else if (index == 2) {
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.policyList,
              arguments: {'regionId': '', 'category': ''},
            );
          }
          // index == 3은 현재 커뮤니티 화면
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: '지도'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
          BottomNavigationBarItem(icon: Icon(Icons.policy), label: '정책'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: '커뮤니티'),
        ],
      ),
    );
  }
}