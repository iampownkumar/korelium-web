import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/blog_post_model.dart';

class BlogService {
  static const String _repoOwner = 'iampownkumar';
  static const String _repoName = 'korelium-blog-posts';
  
  static Future<List<BlogPostModel>> getBlogPosts() async {
    final url = Uri.parse('https://api.github.com/repos/$_repoOwner/$_repoName/issues?state=open');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Exclude pull requests (GitHub API returns PRs as issues too)
        return data
            .where((issue) => issue['pull_request'] == null && issue['body'] != null)
            .map((issue) => BlogPostModel.fromJson(issue))
            .toList();
      } else {
        throw Exception('Failed to load blog posts from GitHub.');
      }
    } catch (e) {
      throw Exception('Failed to load blog posts: $e');
    }
  }
}
