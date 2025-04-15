import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:youth_job_policy_app/models/policy.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PolicyReviewScreen extends StatefulWidget {
  final String policyId;

  const PolicyReviewScreen({
    super.key,
    required this.policyId,
  });

  @override
  State<PolicyReviewScreen> createState() => _PolicyReviewScreenState();
}

class _PolicyReviewScreenState extends State<PolicyReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 3.0;
  bool _isLoading = true;
  bool _isSubmitting = false;
  late Policy _policy;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadPolicyDetails();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _loadPolicyDetails() async {
    // 실제로는 Firebase나 API에서 정책 상세 정보를 가져옵니다
    await Future.delayed(const Duration(seconds: 1));

    // 임시 데이터
    _policy = Policy(
      id: widget.policyId,
      title: 'IT 인재 양성 프로그램',
      description: '청년 IT 개발자 양성을 위한 6개월 교육 프로그램입니다.',
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

  Future<void> _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _submitReview() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        // 리뷰 데이터와 이미지 업로드 로직
        await Future.delayed(const Duration(seconds: 2)); // 업로드 시뮬레이션

        // 여기서 Firebase나 API에 리뷰 데이터 업로드

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('리뷰가 성공적으로 등록되었습니다.')),
        );
        Navigator.pop(context); // 이전 화면으로 돌아가기
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('리뷰 등록에 실패했습니다: ${e.toString()}')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('정책 평가 작성'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _policy.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),

              // 참여 인증 섹션
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '정책 참여 인증',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '정책 참여를 인증할 수 있는 증빙 자료를 업로드해주세요. (참여확인서, 수료증 등)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),

                      // 이미지 업로드 버튼
                      Center(
                        child: Column(
                          children: [
                            _image != null
                                ? Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                                : Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 8),
                                    Text('이미지를 업로드해주세요'),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: _getImage,
                              icon: const Icon(Icons.upload_file),
                              label: const Text('파일 업로드'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 별점 평가 섹션
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '평점',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: RatingBar.builder(
                          initialRating: _rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          '${_rating.toStringAsFixed(1)} / 5.0',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 리뷰 작성 섹션
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '리뷰 작성',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _reviewController,
                        decoration: const InputDecoration(
                          hintText: '정책에 대한 경험과 의견을 자유롭게 작성해주세요.',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '리뷰 내용을 입력해주세요';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 제출 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _image == null || _isSubmitting
                      ? null
                      : _submitReview,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('리뷰 등록하기'),
                ),
              ),
              const SizedBox(height: 8),
              if (_image == null)
                const Center(
                  child: Text(
                    '* 정책 참여 인증 이미지를 업로드해야 리뷰를 등록할 수 있습니다.',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}