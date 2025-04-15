import 'package:flutter/material.dart';
import 'package:youth_job_policy_app/config/routes.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('지역별 일자리 정책'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.profile);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  '여기에 한국 지도가 표시됩니다.\n(실제 지도는 SVG 또는 Google Maps로 구현)',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.policyList,
                  arguments: {'regionId': 'seoul', 'category': ''},
                );
              },
              child: const Text('정책 목록 보기'),
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

          // 탭에 따라 다른 화면으로 이동
          if (index == 0) {
            // 현재 지도 화면
          } else if (index == 1) {
            Navigator.of(context).pushNamed(AppRoutes.profile);
          } else if (index == 2) {
            Navigator.of(context).pushNamed(
              AppRoutes.policyList,
              arguments: {'regionId': '', 'category': ''},
            );
          } else if (index == 3) {
            Navigator.of(context).pushNamed(AppRoutes.community);
          }
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