import 'package:hive/hive.dart';
import '../model/post.dart';

class HiveService {
  static const String postsBoxName = 'posts';

  Future<void> savePosts(List<Post> posts) async {
    var box = await Hive.openBox<Post>(postsBoxName);
    await box.clear();
    for (var post in posts) {
      await box.add(post);
    }
  }

  Future<List<Post>> getPosts() async {
    var box = await Hive.openBox<Post>(postsBoxName);
    List<Post> posts = box.values.toList();
    return posts;
  }
}
