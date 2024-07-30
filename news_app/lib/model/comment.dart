import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'comment.g.dart';

@HiveType(typeId: 1)
class Comment {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String userName;
  
  @HiveField(2)
  String content;
  
  @HiveField(3)
  DateTime timestamp;

  Comment({
    required this.id,
    required this.userName,
    required this.content,
    required this.timestamp,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] ?? '',
      userName: map['userName'] ?? '',
      content: map['content'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
