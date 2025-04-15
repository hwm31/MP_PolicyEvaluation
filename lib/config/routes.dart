import 'package:flutter/material.dart';
import 'package:youth_job_policy_app/screens/community_detail_screen.dart';
import 'package:youth_job_policy_app/screens/community_screen.dart';
import 'package:youth_job_policy_app/screens/login_screen.dart';
import 'package:youth_job_policy_app/screens/map_screen.dart';
import 'package:youth_job_policy_app/screens/policy_detail_screen.dart';
import 'package:youth_job_policy_app/screens/policy_list_screen.dart';
import 'package:youth_job_policy_app/screens/policy_review_screen.dart';
import 'package:youth_job_policy_app/screens/profile_screen.dart';
import 'package:youth_job_policy_app/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String map = '/map';
  static const String profile = '/profile';
  static const String policyList = '/policy-list';
  static const String policyDetail = '/policy-detail';
  static const String policyReview = '/policy-review';
  static const String community = '/community';
  static const String communityDetail = '/community-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case map:
        return MaterialPageRoute(builder: (_) => const MapScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case policyList:
        final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>? ?? {};
        final String regionId = args['regionId'] as String? ?? '';
        final String category = args['category'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => PolicyListScreen(regionId: regionId, category: category),
        );
      case policyDetail:
        final String policyId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => PolicyDetailScreen(policyId: policyId),
        );
      case policyReview:
        final String policyId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => PolicyReviewScreen(policyId: policyId),
        );
      case community:
        return MaterialPageRoute(builder: (_) => const CommunityScreen());
      case communityDetail:
        final String postId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => CommunityDetailScreen(postId: postId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}