// providers/user_provider.dart
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = '';
  String _region = '';
  String _jobField = '';
  String _jobType = '';
  String _education = '';

  String get name => _name;
  String get region => _region;
  String get jobField => _jobField;
  String get jobType => _jobType;
  String get education => _education;

  void updateProfile({
    String? name,
    String? region,
    String? jobField,
    String? jobType,
    String? education,
  }) {
    if (name != null) _name = name;
    if (region != null) _region = region;
    if (jobField != null) _jobField = jobField;
    if (jobType != null) _jobType = jobType;
    if (education != null) _education = education;
    notifyListeners();
  }
}