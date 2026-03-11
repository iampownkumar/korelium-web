import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/responsive_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void _initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeOut)),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Container(
          width: ResponsiveLayout.isDesktop(context) ? 1000 : double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome to Korelium",
                    style: TextStyle(
                      color: AppColors.cyan,
                      fontSize: 18,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [AppColors.cyan, AppColors.jade],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      "Where Fantasy\nMeets Reality.",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: ResponsiveLayout.isMobile(context) ? 48 : 72,
                            height: 1.1,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "I am Pownkumar, a Senior Engineer weaving scalable architectures and elegant interfaces. Currently expanding the horizons of the web.",
                    style: TextStyle(fontSize: 18, height: 1.6, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 48),
                  
                  // Socials
                  Row(
                    children: [
                      _SocialIcon(
                        icon: Icons.link, // Placeholder for LinkedIn
                        label: 'LinkedIn',
                        onTap: () => _launchUrl('https://www.linkedin.com/in/iampownkumar/'),
                      ),
                      const SizedBox(width: 16),
                      _SocialIcon(
                        icon: Icons.code, // Placeholder for GitHub
                        label: 'GitHub',
                        onTap: () => _launchUrl('https://github.com/iampownkumar'),
                      ),
                      const SizedBox(width: 16),
                      _SocialIcon(
                        icon: Icons.alternate_email, // Placeholder for Twitter/X
                        label: 'Twitter',
                        onTap: () => _launchUrl('https://twitter.com/iampownkumar'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 80),

                  // Currently Doing Section
                  _SectionHeader(title: "Currently Doing"),
                  const SizedBox(height: 16),
                  _buildGlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.rocket_launch, color: AppColors.jade, size: 24),
                            SizedBox(width: 12),
                            Text(
                              "Building Korelium",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Pioneering feature services and advanced platforms. Exploring the edge of modern UI engineering with Flutter and rich ambient web experiences.",
                          style: TextStyle(fontSize: 16, color: AppColors.textSecondary, height: 1.5),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cyan.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: child,
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialIcon({required this.icon, required this.label, required this.onTap});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovering ? AppColors.cyan.withOpacity(0.2) : Colors.transparent,
            border: Border.all(color: _isHovering ? AppColors.cyan : AppColors.textSecondary.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(30),
            boxShadow: _isHovering
                ? [BoxShadow(color: AppColors.cyan.withOpacity(0.4), blurRadius: 10)]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 20, color: _isHovering ? AppColors.cyan : AppColors.textPrimary),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovering ? AppColors.cyan : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 32,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.cyan.withOpacity(0.5), Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
