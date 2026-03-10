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
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/about',
            builder: (context, state) => const AboutScreen(),
          ),
          GoRoute(
            path: '/blog',
            builder: (context, state) => const BlogListScreen(),
          ),
          GoRoute(
            path: '/portfolio',
            builder: (context, state) => const PortfolioScreen(),
          ),
        ],
      ),
    ],
  );
}
