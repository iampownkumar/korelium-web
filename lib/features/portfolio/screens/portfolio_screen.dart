import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/responsive_layout.dart';
import '../data/projects_data.dart';
import '../models/project_model.dart';

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
                children: portfolioProjects.map((project) => _buildProjectCard(project: project, context: context)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard({required ProjectModel project, required BuildContext context}) {
    final double width = ResponsiveLayout.isMobile(context) 
        ? double.infinity 
        : (ResponsiveLayout.isDesktop(context) ? 450 : 320);

    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: project.isFeatured 
              ? AppColors.jade.withOpacity(0.5) 
              : AppColors.textSecondary.withOpacity(0.2)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.cyan.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.cyan.withOpacity(0.5)),
                ),
                child: Text(project.tag, style: const TextStyle(fontSize: 12, color: AppColors.cyan, fontWeight: FontWeight.bold)),
              ),
              if (project.githubUrl != null)
                IconButton(
                  icon: const Icon(Icons.code, color: AppColors.textSecondary),
                  tooltip: 'View Source Code',
                  onPressed: () => _launchURL(project.githubUrl!),
                )
            ],
          ),
          const SizedBox(height: 16),
          Text(project.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          Text(project.description, style: const TextStyle(fontSize: 16, color: AppColors.textSecondary, height: 1.5)),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
