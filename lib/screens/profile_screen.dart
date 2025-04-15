import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_job_policy_app/providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String _jobField = '';
  String _jobType = '정규직';
  String _region = '서울특별시';
  String _education = '대학 재학';

  List<String> jobTypes = ['정규직', '인턴십', '창업'];
  List<String> regions = ['서울특별시', '부산광역시', '대구광역시', '인천광역시', '광주광역시', '대전광역시', '울산광역시', '세종특별자치시'];
  List<String> educations = ['고등학교 졸업', '대학 재학', '대학 졸업', '대학원 이상'];

  @override
  void initState() {
    super.initState();
    // 기존 사용자 데이터 로드
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.jobField.isNotEmpty) {
      _jobField = userProvider.jobField;
    }
    if (userProvider.jobType.isNotEmpty) {
      _jobType = userProvider.jobType;
    }
    if (userProvider.region.isNotEmpty) {
      _region = userProvider.region;
    }
    if (userProvider.education.isNotEmpty) {
      _education = userProvider.education;
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.updateProfile(
        jobField: _jobField,
        jobType: _jobType,
        region: _region,
        education: _education,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('프로필이 저장되었습니다')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일자리 관심 프로필 설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                '희망 직무 분야',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _jobField,
                decoration: const InputDecoration(
                  hintText: 'IT/개발, 디자인, 마케팅, 경영/사무, 교육 등',
                ),
                onSaved: (value) {
                  if (value != null) {
                    _jobField = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '희망 직무 분야를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              Text(
                '취업 유형',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: jobTypes.map((type) {
                  return ChoiceChip(
                    label: Text(type),
                    selected: _jobType == type,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _jobType = type;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              Text(
                '희망 지역',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _region,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: regions.map((region) {
                  return DropdownMenuItem<String>(
                    value: region,
                    child: Text(region),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _region = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),

              Text(
                '학력',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: educations.map((edu) {
                  return ChoiceChip(
                    label: Text(edu),
                    selected: _education == edu,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _education = edu;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('저장 및 맞춤 정책 확인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}