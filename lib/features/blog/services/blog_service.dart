import 'package:flutter/services.dart' show rootBundle;

class BlogPost {
  final String id;
  final String title;
  final String summary;
  final String contentPath;

  BlogPost({
    required this.id,
    required this.title,
    required this.summary,
    required this.contentPath,
  });
}

class BlogService {
  // Hardcoded list for now, later could be fetched from an API or generated
  static final List<BlogPost> posts = [
    BlogPost(
      id: 'first_post',
      title: 'My First Post',
      summary: 'Welcome to my incredible new Donghua-inspired Flutter web portfolio.',
      contentPath: 'assets/blog/first_post.md',
    ),
  ];

  static Future<String> loadPostContent(String path) async {
    try {
      return await rootBundle.loadString(path);
    } catch (e) {
      return '# Error loading post\nCould not find content at $path.';
    }
  }
}
