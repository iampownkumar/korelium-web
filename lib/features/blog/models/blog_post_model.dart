import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory BlogPostModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BlogPostModel(
      id: doc.id,
      title: data['title'] ?? 'Untitled',
      summary: data['summary'] ?? '',
      content: data['content'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
