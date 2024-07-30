import 'package:flutter/material.dart';
import './login_page.dart';
import '../components/home_drawer.dart';
import '../controllers/post_provider.dart';
import 'package:provider/provider.dart';
import '../components/post_card.dart';
import '../model/post.dart';
import '../components/add_post_dialog.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  HomeScreen({required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostProvider>(context, listen: false).setCurrentUsername(widget.username);
      Provider.of<PostProvider>(context, listen: false).loadPosts();
    });
  }
  void _showAddPostDialog() {
    showDialog(context: context, builder: (context) => AddPostDialog());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Post Feed'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      drawer: HomeDrawer(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 48),
              Text(
                'New Post',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                onPressed: _showAddPostDialog,
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          if (postProvider.posts.isEmpty) {
            return Center(child: Text('No posts available.'));
          } else {
            print("Posts available: ${postProvider.posts.length}"); // Debug print
            return ListView.builder(
              itemCount: postProvider.posts.length,
              itemBuilder: (context, index) {
                Post post = postProvider.posts[index];
                print("Post: ${post.toMap()}"); // Debug print
                return PostCard(post: post);
              },
            );
          }
        },
      ),
    );
  }
}
