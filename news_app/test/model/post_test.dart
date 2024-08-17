import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/model/post.dart';

void main() {
  group('Post Model Test', () {
    test('Post model should toggle like correctly', () {
      final post = Post(
        id: '1',
        userName: 'user1',
        content: 'This is a test post',
        timestamp: DateTime.now(),
        likeCount: 0,
        photoUrl: '',
        likedBy: [],
        comments: [],
      );

      expect(post.isLikedBy('user1'), isFalse);

      post.toggleLike('user1');
      expect(post.isLikedBy('user1'), isTrue);
      expect(post.likeCount, 1);

      post.toggleLike('user1');
      expect(post.isLikedBy('user1'), isFalse);
      expect(post.likeCount, 0);
    });
  });
}
