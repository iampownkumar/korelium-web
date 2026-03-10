import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/blog_post_model.dart';

class BlogService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Stream<List<BlogPostModel>> getBlogPosts() {
    return _firestore
        .collection('blog_posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => BlogPostModel.fromFirestore(doc)).toList();
    });
  }
}
