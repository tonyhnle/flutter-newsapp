import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/controllers/post_provider.dart';
import 'package:provider/provider.dart';
import 'package:news_app/views/login_page.dart';
import './themes/light_mode.dart';
import './themes/dark_mode.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/post.dart';
import '../model/comment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(CommentAdapter());
  
  await Hive.openBox<Post>('posts');
  await Hive.openBox<Comment>('comments');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()..loadPosts())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightMode,
        darkTheme: darkMode,
        home: LoginScreen(),
      ),
    );
  }
}

