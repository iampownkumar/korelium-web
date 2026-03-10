import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/about/screens/about_screen.dart';
import '../../features/blog/screens/blog_list_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/portfolio/screens/portfolio_screen.dart';
import '../../shared/widgets/scaffold_with_nav_bar.dart';

// Global key for top-level navigator
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            path: '/about',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const AboutScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            path: '/blog',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const BlogListScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            path: '/portfolio',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const PortfolioScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
        ],
      ),
    ],
  );
}
