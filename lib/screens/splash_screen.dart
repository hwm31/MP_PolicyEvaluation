// screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youth_job_policy_app/config/routes.dart';
import 'package:youth_job_policy_app/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2)); // 스플래시 화면을 2초 동안 보여줍니다

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.isLoggedIn) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.map);
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 24),
            Text(
              '청년 일자리 정책',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 8),
            Text(
              '맞춤 정책 추천 및 평가 앱',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 32),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}