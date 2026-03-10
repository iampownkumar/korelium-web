import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/responsive_layout.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Container(
          width: ResponsiveLayout.isDesktop(context) ? 800 : double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Me",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 48,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 32),
              const Text(
                "I am Pownkumar.",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.cyan,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "A Senior Engineer with a passion for building elegant, scalable, and immersive digital experiences. Currently, I am pouring my heart into building Korelium—a place where fantasy meets reality. Korelium is more than just a project; it is a philosophy of blending highly technical, performant architectures with visually stunning aesthetics.",
                style: TextStyle(fontSize: 18, color: AppColors.textPrimary, height: 1.6),
              ),
              const SizedBox(height: 48),

              // Experience Section
              _buildTimelineItem(
                title: 'Founder & Lead Engineer',
                company: 'Korelium',
                period: 'Present',
                description: 'Pioneering new platform architectures, feature services, and rich web interfaces using Flutter, NextJS, and robust backend systems.',
              ),
              const SizedBox(height: 24),
              _buildTimelineItem(
                title: 'Senior Software Engineer',
                company: 'Various',
                period: 'Past',
                description: 'Scaled applications, optimized performant data architectures, and led teams to deliver high-quality software solutions.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem({required String title, required String company, required String period, required String description}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.jade.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
              ),
              Text(
                period,
                style: const TextStyle(fontSize: 14, color: AppColors.jade, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            company,
            style: const TextStyle(fontSize: 16, color: AppColors.cyan),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(fontSize: 16, color: AppColors.textSecondary, height: 1.5),
          ),
        ],
      ),
    );
  }
}
