import 'dart:convert';

class BlogPostModel {
  final String id;
  final String title;
  final String summary;
  final String content;
  final DateTime createdAt;

  BlogPostModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.createdAt,
  });

  factory BlogPostModel.fromJson(Map<String, dynamic> data) {
    String body = data['body'] ?? '';
    String summaryStr = _extractSummary(body);

    return BlogPostModel(
      id: data['id'].toString(),
      title: data['title'] ?? 'Untitled',
      summary: summaryStr,
      content: body,
      createdAt: data['created_at'] != null 
          ? DateTime.parse(data['created_at']) 
          : DateTime.now(),
    );
  }

  static String _extractSummary(String markdownText) {
    // A simple parser to extract the first paragraph as a summary
    final lines = markdownText.split('\n');
    for (var line in lines) {
      final trimmed = line.trim();
      // Skip headers and empty lines
      if (trimmed.isNotEmpty && !trimmed.startsWith('#') && !trimmed.startsWith('!')) {
        return trimmed.length > 150 ? '${trimmed.substring(0, 147)}...' : trimmed;
      }
    }
    return '';
  }
}
