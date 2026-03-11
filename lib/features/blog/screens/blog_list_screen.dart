import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/responsive_layout.dart';
import '../models/blog_post_model.dart';
import '../services/blog_service.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  BlogPostModel? _selectedPost;

  void _openPost(BlogPostModel post) {
    setState(() {
      _selectedPost = post;
    });
  }

  void _closePost() {
    setState(() {
      _selectedPost = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedPost != null) {
      return _buildPostReader(_selectedPost!);
    }

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
                "Transmissions",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 48,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Thoughts, tutorials, and stories from the edge.",
                style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 48),
              
              StreamBuilder<List<BlogPostModel>>(
                stream: BlogService.getBlogPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(48.0),
                        child: CircularProgressIndicator(color: AppColors.jade),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text('Error receiving transmissions: ${snapshot.error}', style: const TextStyle(color: Colors.red));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No active transmissions found at this time.", style: TextStyle(color: AppColors.textSecondary));
                  }
                  
                  return Column(
                     children: snapshot.data!.map((post) => _buildBlogCard(post)).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogCard(BlogPostModel post) {
    final dateStr = "${post.createdAt.year}-${post.createdAt.month.toString().padLeft(2, '0')}-${post.createdAt.day.toString().padLeft(2, '0')}";
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _openPost(post),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cyan.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      post.title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                  ),
                  Text(
                    dateStr,
                    style: const TextStyle(color: AppColors.cyan, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                post.summary,
                style: const TextStyle(fontSize: 16, color: AppColors.textSecondary, height: 1.5),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text("Read full transmission", style: TextStyle(color: AppColors.jade, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 16, color: AppColors.jade),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostReader(BlogPostModel post) {
    final dateStr = "${post.createdAt.year}-${post.createdAt.month.toString().padLeft(2, '0')}-${post.createdAt.day.toString().padLeft(2, '0')}";
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Container(
          width: ResponsiveLayout.isDesktop(context) ? 800 : double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _closePost,
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back, color: AppColors.cyan),
                    SizedBox(width: 8),
                    Text("Back to Transmissions", style: TextStyle(color: AppColors.cyan, fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                post.title,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 40,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                "Published on $dateStr",
                style: const TextStyle(color: AppColors.cyan, fontSize: 16),
              ),
              const SizedBox(height: 48),
              MarkdownBody(
                data: post.content.replaceAll(r'\n', '\n').replaceAll(r'\\n', '\n'),
                styleSheet: MarkdownStyleSheet(
                  h1: const TextStyle(color: AppColors.textPrimary, fontSize: 36, fontWeight: FontWeight.bold),
                  h2: const TextStyle(color: AppColors.cyan, fontSize: 24, fontWeight: FontWeight.bold),
                  h3: const TextStyle(color: AppColors.jade, fontSize: 20, fontWeight: FontWeight.bold),
                  p: const TextStyle(color: AppColors.textSecondary, fontSize: 18, height: 1.6),
                  listBullet: const TextStyle(color: AppColors.jade),
                  blockquoteDecoration: BoxDecoration(
                    border: const Border(left: BorderSide(color: AppColors.cyan, width: 4)),
                    color: AppColors.surface.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
