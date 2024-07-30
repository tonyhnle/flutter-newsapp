import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import '../model/post.dart';
import '../model/comment.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload image to Firebase Storage and return the URL
  Future<String> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('images/$fileName.png');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print('Image uploaded, URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  // Add a new post with the image URL
  Future<void> addPost(Post post) async {
    try {
      DocumentReference docRef = await _firestore.collection('posts').add(post.toMap());
      post.id = docRef.id;
      await docRef.update(post.toMap());
    } catch (e) {
      print('Error adding post: $e');
    }
  }

  Future<List<Post>> getPosts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('posts').get();
      List<Post> posts = snapshot.docs.map((doc) {
        return Post.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      print('Fetched posts: $posts');  // Debug print
      return posts;
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }

  // Fetch comments for a specific post
  Future<List<Comment>> getComments(String postId) async {
    QuerySnapshot snapshot = await _firestore.collection('posts').doc(postId).collection('comments').get();
    return snapshot.docs.map((doc) => Comment.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> updatePost(Post post) async {
    try {
      await _firestore.collection('posts').doc(post.id).update(post.toMap());
    } catch (e) {
      print('Error updating post: $e');
    }
  }

    Future<void> addComment(String postId, Comment comment) async {
    try {
      DocumentReference postRef = _firestore.collection('posts').doc(postId);
      await postRef.update({
        'comments': FieldValue.arrayUnion([comment.toMap()])
      });
    } catch (e) {
      print('Error adding comment: $e');
    }
  }


}

