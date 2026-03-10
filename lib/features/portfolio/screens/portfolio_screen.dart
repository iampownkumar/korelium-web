import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/responsive_layout.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Container(
          width: ResponsiveLayout.isDesktop(context) ? 1000 : double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Projects & Creations",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 48,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 16),
              const Text(
                "A showcase of the worlds I have built and the systems I have constructed.",
                style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 48),

              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  _buildProjectCard(
                    title: 'Korelium Platform',
                    description: 'A cutting-edge platform where fantasy meets reality. Built with advanced web technologies to deliver highly scalable features.',
                    tag: 'Architecture / Fullstack',
                    context: context,
                  ),
                  _buildProjectCard(
                    title: 'Donghua Canvas Engine',
                    description: 'Experimenting with Flutter CustomPainters to create silky 60FPS fluid particle systems for the web.',
                    tag: 'Flutter / UI / Graphics',
                    context: context,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard({required String title, required String description, required String tag, required BuildContext context}) {
    final double width = ResponsiveLayout.isMobile(context) 
        ? double.infinity 
        : (ResponsiveLayout.isDesktop(context) ? 450 : 320);

    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textSecondary.withOpacity(0.2)),
        // Subtle hover effects would be added in a stateful wrapping here.
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.cyan.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.cyan.withOpacity(0.5)),
            ),
            child: Text(tag, style: const TextStyle(fontSize: 12, color: AppColors.cyan, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          Text(description, style: const TextStyle(fontSize: 16, color: AppColors.textSecondary, height: 1.5)),
        ],
      ),
    );
  }
}
