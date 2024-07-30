import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'comment.dart';  

part 'post.g.dart';

@HiveType(typeId: 0)
class Post {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String userName;
  
  @HiveField(2)
  String content;
  
  @HiveField(3)
  DateTime timestamp;
  
  @HiveField(4)
  int likeCount;
  
  @HiveField(5)
  String photoUrl;
  
  @HiveField(6)
  List<String> likedBy;
  
  @HiveField(7)
  List<Comment> comments;  

  Post({
    required this.id,
    required this.userName,
    required this.content,
    required this.timestamp,
    required this.likeCount,
    required this.photoUrl,
    required this.likedBy,
    required this.comments,  
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      userName: map['userName'] ?? '',
      content: map['content'] ?? '',
      timestamp: parseTimestamp(map['timestamp']),  // Convert Timestamp
      likeCount: map['likeCount'] ?? 0,
      photoUrl: map['photoUrl'] ?? '',
      likedBy: List<String>.from(map['likedBy'] ?? []),
      comments: (map['comments'] as List<dynamic>? ?? []).map((item) => Comment.fromMap(item)).toList(),
    );
  }

  static DateTime parseTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else if (timestamp is String) {
      return DateTime.parse(timestamp);  // Parse ISO 8601 string directly
    } else {
      throw ArgumentError("Unsupported timestamp format");
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),  // Convert DateTime to Timestamp
      'likeCount': likeCount,
      'photoUrl': photoUrl,
      'likedBy': likedBy,
      'comments': comments.map((comment) => comment.toMap()).toList(),
    };
  }

  bool isLikedBy(String username) {
    return likedBy.contains(username);
  }

  void toggleLike(String username) {
    if (isLikedBy(username)) {
      likedBy.remove(username);
      likeCount--;
    } else {
      likedBy.add(username);
      likeCount++;
    }
  }

  void addComment(Comment comment) {
    comments.add(comment);
  }
}
