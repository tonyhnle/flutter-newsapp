import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/post.dart';
import '../controllers/post_provider.dart';
import 'package:intl/intl.dart';
import '../components/add_comment_dialog.dart';
import '../components/view_comments_dialog.dart';

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    String currentUsername = Provider.of<PostProvider>(context, listen: false).currentUsername;
    String formattedTimeStamp = DateFormat('MM-dd-yyyy HH:mm').format(post.timestamp);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.photoUrl.isNotEmpty)
              Image.network(
                post.photoUrl,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('img/1080x1080.png');  //Local placeholder image
                },
              ),
            SizedBox(height: 10),
            Text(post.userName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 5),
            Text(post.content, style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text(
              formattedTimeStamp,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${post.likeCount} Likes', style: TextStyle(fontSize: 14)),
                IconButton(
                  icon: Icon(
                    post.isLikedBy(currentUsername) ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                    color: post.isLikedBy(currentUsername) ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    Provider.of<PostProvider>(context, listen: false).toggleLike(post);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    showDialog(context: context,
                    builder: (context) => AddCommentDialog(postId: post.id),
                    );
                  },
                  ),
              ],
            ),
            Divider(),
            Text('Comments:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...post.comments.take(3).map((comment) => ListTile(
              title: Text(comment.userName, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(comment.content),
              trailing: Text(DateFormat('yyyy-MM-dd – kk:mm').format(comment.timestamp)),
            )).toList(),
            if (post.comments.length > 3)
              TextButton(
                onPressed: () {
                  showDialog(context: context, 
                  builder: (context) => ViewCommentsDialog(comments: post.comments),
                  
                  );
                } ,
                child: Text('View all comments', style: Theme.of(context).textTheme.bodyLarge),
                ) 
          ],
        ),
      ),
    );
  }
}
