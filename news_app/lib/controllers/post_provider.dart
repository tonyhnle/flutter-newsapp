import 'package:flutter/material.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import '../model/post.dart';
import '../model/comment.dart';
import '../controllers/firebase_service.dart';
import '../controllers/hive_service.dart';

class PostProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  final HiveService _hiveService = HiveService();
  String _currentUsername = '';
  List<Post> _posts = [];

  List<Post> get posts => _posts;
  String get currentUsername => _currentUsername;

  void setCurrentUsername(String username) {
    _currentUsername = username;
    notifyListeners();
  }

  Future<void> loadPosts() async {
    print('Loading posts...');
    _posts = await _firebaseService.getPosts();
    _posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));  // Sort posts by timestamp in descending order
    print('Loaded posts: $_posts');  // Debug print
    await _hiveService.savePosts(_posts);
    notifyListeners();
  }

  Future<void> addPost(String userName, String content, File? imageFile) async {
    String imageUrl = '';
    if (imageFile != null) {
      imageUrl = await _firebaseService.uploadImage(imageFile);
    }
    print('Adding post: userName=$userName, content=$content, imageFile=${imageFile?.path}');
    print('image url: ${imageUrl}');
    Post newPost = Post(
      id: '',
      userName: userName,
      content: content,
      timestamp: DateTime.now(),
      likeCount: 0,
      photoUrl: imageUrl, // This will be an empty string if no image is uploaded
      likedBy: [],
      comments: [], 
    );
    await _firebaseService.addPost(newPost);
    _posts.add(newPost);
    _posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    await _hiveService.savePosts(_posts);
    notifyListeners();
  }

  Future<void> samplePost() async {
    Post newPost = Post(
      id: '',
      userName: 'sample',
      content: 'this is a sample post',
      timestamp: DateTime.now(),
      likeCount: 0,
      photoUrl: 'https://placehold.co/1080x1080.png',
      likedBy: [],
      comments: [], 
    );
    await _firebaseService.addPost(newPost);
    print('Sample post added: ${newPost.toMap()}');  // Debug print
    _posts.add(newPost);
    _posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    await _hiveService.savePosts(_posts);
    notifyListeners();
  }

  Future<void> addComment(String postId, String userName, String content) async {
    Comment newComment = Comment(
      id: '',
      userName: userName,
      content: content,
      timestamp: DateTime.now(),
    );
    await _firebaseService.addComment(postId, newComment);

    // Find the post and add the new comment locally
    Post post = _posts.firstWhere((p) => p.id == postId);
    post.comments.add(newComment);

    await savePostToHive(post);
    notifyListeners();
  }

  Future<void> toggleLike(Post post) async {
    post.toggleLike(_currentUsername);
    await _firebaseService.updatePost(post);
    await savePostToHive(post);
    notifyListeners();
  }

  Future<void> savePostToHive(Post post) async {
    var box = await Hive.openBox<Post>('posts');
    int index = box.values.toList().indexWhere((p) => p.id == post.id);
    if (index != -1) {
      box.putAt(index, post);
    } else {
      box.add(post);
    }
  }
}
