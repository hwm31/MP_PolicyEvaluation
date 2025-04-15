// providers/policy_provider.dart
import 'package:flutter/material.dart';
import 'package:youth_job_policy_app/models/policy.dart';

class PolicyProvider extends ChangeNotifier {
  List<Policy> _policies = [];
  bool _isLoading = false;
  String _error = '';

  List<Policy> get policies => _policies;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchPolicies({String? region, String? category}) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      // 여기서 Firebase나 API를 통해 정책 데이터를 가져옵니다
      // 임시 데이터로 대체합니다
      await Future.delayed(const Duration(seconds: 1));
      _policies = []; // 실제 데이터로 업데이트
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}