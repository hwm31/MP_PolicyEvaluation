import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_job_policy_app/providers/auth_provider.dart';

class CommunityDetailScreen extends StatefulWidget {
  final String postId;

  const CommunityDetailScreen({
    super.key,
    required this.postId,
  });

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  final _commentController = TextEditingController();
  bool _isLoading = true;

  // 임시 게시글 데이터
  late Map<String, dynamic> _post;

  // 임시 댓글 데이터
  List<Map<String, dynamic>> _comments = [];

  @override
  void initState() {
    super.initState();
    _loadPostData();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadPostData() async {
    // 실제로는 Firebase나 API에서 게시글 데이터를 가져옵니다
    await Future.delayed(const Duration(seconds: 1));

    // 임시 게시글 데이터
    _post = {
      'id': widget.postId,
      'title': 'IT 인재 양성 프로그램 후기 공유합니다',
      'author': '김청년',
      'category': '후기',
      'createdAt': DateTime.now().subtract(const Duration(days: 2)),
      'views': 129, // 조회수 1 증가
      'comments': 24,
      'content': '안녕하세요. 서울시 IT 인재 양성 프로그램에 참여한 김청년입니다.\n\n'
          '6개월간의 프로그램을 통해 웹 개발과 앱 개발 기술을 배울 수 있었고, 프로그램 종료 후 2주 만에 IT 중소기업에 취업할 수 있었습니다.\n\n'
          '특히 좋았던 점은:\n'
          '1. 실무 중심의 교육 커리큘럼\n'
          '2. 매월 지원되는 교육 지원금\n'
          '3. 취업 연계 서비스\n\n'
          '교육 내용은 최신 기술 트렌드를 반영하고 있어 실제 취업 시 큰 도움이 되었습니다. 강사진들도 현업에서 일하고 계신 분들이라 실질적인 조언을 많이 들을 수 있었습니다.\n\n'
          '같은 프로그램을 고민하시는 분들께 적극 추천드립니다!',
      'isMP': false,
    };

    // 임시 댓글 데이터
    _comments = [
      {
        'id': 'comment1',
        'author': '박청년',
        'content': '저도 지원하려고 하는데 도움이 많이 됐어요! 감사합니다.',
        'createdAt': DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        'isMP': false,
      },
      {
        'id': 'comment2',
        'author': '이의원',
        'content': '좋은 후기 감사합니다. 다음 기수에는 AI 과정도 추가될 예정입니다.',
        'createdAt': DateTime.now().subtract(const Duration(hours: 18)),
        'isMP': true,
      },
      {
        'id': 'comment3',
        'author': '최취업',
        'content': '혹시 면접은 어떤 방식으로 진행되었나요?',
        'createdAt': DateTime.now().subtract(const Duration(hours: 5)),
        'isMP': false,
      },
    ];

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _submitComment() async {
    if (_commentController.text.isEmpty) return;

    // 실제로는 Firebase나 API에 댓글을 저장합니다
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isMP = authProvider.isMP;

    setState(() {
      _comments.add({
        'id': 'new-comment-${DateTime.now().millisecondsSinceEpoch}',
        'author': isMP ? '이의원' : '사용자',
        'content': _commentController.text,
        'createdAt': DateTime.now(),
        'isMP': isMP,
      });

      _post['comments'] = _comments.length;
      _commentController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('댓글이 등록되었습니다')),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // 공유 기능 구현
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('게시글 공유 기능은 준비 중입니다')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // 더 보기 메뉴 구현
              _showMoreOptions(context);
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // 게시글 내용
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 게시글 헤더
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(_post['category']),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _post['category'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      if (_post['isMP'])
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
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 게시글 제목
                  Text(
                    _post['title'],
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),

                  // 작성자 정보
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey[300],
                        child: Text(
                          _post['author'].substring(0, 1),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _post['author'],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(_post['createdAt']),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),

                  const Divider(height: 32),

                  // 게시글 본문
                  Text(
                    _post['content'],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 24),

                  // 조회수, 댓글수 표시
                  Row(
                    children: [
                      const Icon(Icons.remove_red_eye, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${_post['views']}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.comment, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${_post['comments']}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),

                  const Divider(height: 32),

                  // 댓글 섹션 제목
                  Text(
                    '댓글 ${_comments.length}개',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  // 댓글 목록
                  ..._comments.map((comment) => _buildCommentItem(comment)),
                ],
              ),
            ),
          ),

          // 댓글 입력창
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, -1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _submitComment,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    final bool isMP = comment['isMP'] as bool;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: isMP
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Colors.grey[300],
                child: Text(
                  comment['author'].substring(0, 1),
                  style: TextStyle(
                    color: isMP
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                comment['author'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isMP)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '정책담당자',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 10,
                    ),
                  ),
                ),
              const Spacer(),
              Text(
                _formatDate(comment['createdAt']),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36.0, top: 8.0),
            child: Text(comment['content']),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.bookmark),
                title: const Text('저장하기'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('게시글이 저장되었습니다')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.report),
                title: const Text('신고하기'),
                onTap: () {
                  Navigator.pop(context);
                  _showReportDialog(context);
                },
              ),
              // 작성자나 관리자일 경우에만 보이는 옵션
              if (_post['author'] == '김청년' || Provider.of<AuthProvider>(context, listen: false).isMP)
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('수정하기'),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('게시글 수정 기능은 준비 중입니다')),
                    );
                  },
                ),
              if (_post['author'] == '김청년' || Provider.of<AuthProvider>(context, listen: false).isMP)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('삭제하기'),
                  onTap: () {
                    Navigator.pop(context);
                    _showDeleteConfirmDialog(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('게시글 신고'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('신고 사유를 선택해주세요'),
              const SizedBox(height: 16),
              _buildReportOption('스팸 또는 광고'),
              _buildReportOption('욕설 또는 혐오 발언'),
              _buildReportOption('허위 정보'),
              _buildReportOption('기타'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('신고가 접수되었습니다')),
                );
              },
              child: const Text('신고하기'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReportOption(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            const Icon(Icons.circle_outlined, size: 20),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('게시글 삭제'),
          content: const Text('정말로 이 게시글을 삭제하시겠습니까? 이 작업은 취소할 수 없습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
                Navigator.pop(context); // 게시글 화면 닫기
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('게시글이 삭제되었습니다')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );
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
}