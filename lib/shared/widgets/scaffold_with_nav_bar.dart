import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import 'responsive_layout.dart';
import 'ambient_background.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Basic subtle gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xFF131c26), AppColors.background],
                radius: 1.5,
                center: Alignment.topLeft,
              ),
            ),
          ),
          // Flowing Donghua Custom Painter
          const Positioned.fill(child: AmbientBackground()),
          // Main content
          SafeArea(child: child),
          // Glassmorphic Nav Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveLayout.isDesktop(context) ? 100 : 20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.5),
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.cyan.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo
                      GestureDetector(
                        onTap: () => context.go('/'),
                        child: Text(
                          'KORELIUM',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 24,
                                color: AppColors.jade,
                                letterSpacing: 2,
                              ),
                        ),
                      ),
                      // Nav Links (Desktop)
                      if (ResponsiveLayout.isDesktop(context) || ResponsiveLayout.isTablet(context))
                        Row(
                          children: [
                            _NavBarItem(title: 'Home', path: '/'),
                            const SizedBox(width: 30),
                            _NavBarItem(title: 'About', path: '/about'),
                            const SizedBox(width: 30),
                            _NavBarItem(title: 'Blog', path: '/blog'),
                            const SizedBox(width: 30),
                            _NavBarItem(title: 'Portfolio', path: '/portfolio'),
                          ],
                        ),
                      // Hamburger Menu (Mobile)
                      if (ResponsiveLayout.isMobile(context))
                        IconButton(
                          icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                          onPressed: () {
                            // Mobile menu implementation
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final String title;
  final String path;

  const _NavBarItem({
    required this.title,
    required this.path,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final bool isActive = GoRouterState.of(context).uri.toString() == widget.path;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(widget.path),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _isHovering ? AppColors.cyan.withOpacity(0.1) : Colors.transparent,
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isActive || _isHovering ? AppColors.cyan : AppColors.textPrimary,
              shadows: isActive || _isHovering
                  ? [
                      Shadow(
                        color: AppColors.cyan.withOpacity(0.5),
                        blurRadius: 10,
                      ),
                    ]
                  : [],
            ),
          ),
        ),
      ),
    );
  }
}
