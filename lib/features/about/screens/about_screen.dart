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
                "A specialist in Linux-based systems, automation, and multi-platform environments. My background includes robust system administration, automation scripting, and lab infrastructure management. \n\nI am currently focusing on DevOps and Infrastructure Engineering, with a deep interest in system internals, networking, and cloud technologies. While I actively build and research, Korelium remains my central avenue for blending high-performance architectures with visually stunning web aesthetics.",
                style: TextStyle(fontSize: 18, color: AppColors.textPrimary, height: 1.6),
              ),
              const SizedBox(height: 48),

              Text(
                "Education",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 32,
                      color: AppColors.jade,
                    ),
              ),
              const SizedBox(height: 16),
              _buildTimelineItem(
                title: 'Bachelor of Computer Applications (BCA)',
                company: "Pachaiyappa's College, Chennai",
                period: '2017 - 2020',
                description: 'Foundational studies in computer science, software engineering, and applications.',
              ),
              const SizedBox(height: 48),

              Text(
                "Experience",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 32,
                      color: AppColors.cyan,
                    ),
              ),
              const SizedBox(height: 16),

              // Experience Section
              _buildTimelineItem(
                title: 'Lab Instructor (Systems & Infrastructure)',
                company: 'Rajalakshmi Institute of Technology',
                period: 'Oct 2025 - Present',
                description: 'Managing lab systems, automating operations (shutdown scheduling, remote management), and providing technical support for hardware and networking across multiple platforms. Created the Mac Lab Admin Controller toolkit using Fish shell and SSH.',
              ),
              const SizedBox(height: 24),
              _buildTimelineItem(
                title: 'Delhivery Agent',
                company: 'Delhivery',
                period: 'Mar 2024 - Aug 2024',
                description: 'Ensured precise and timely logistics operations and deliveries within assigned sectors.',
              ),
              const SizedBox(height: 24),
              _buildTimelineItem(
                title: 'AML Transaction Monitoring Specialist',
                company: 'FIS',
                period: 'May 2019 - Aug 2022',
                description: 'Analyzed alerts for suspicious financial activity, conducted risk investigations using tools like LexisNexis, and prepared Suspicious Activity Reports (SAR).',
              ),
              const SizedBox(height: 24),
              _buildTimelineItem(
                title: 'Customer Support Specialist',
                company: 'Fast Track Call Taxi',
                period: 'Aug 2018 - Apr 2019',
                description: 'Provided frontline support and resolved customer inquiries efficiently.',
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
