import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/post_provider.dart';

class AddCommentDialog extends StatefulWidget {
  final String postId;

  AddCommentDialog({required this.postId});

  @override
  _AddCommentDialogState createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Comment'),
      content: TextField(
        controller: _commentController,
        decoration: InputDecoration(labelText: 'Comment'),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.inversePrimary)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_commentController.text.isNotEmpty) {
              String username = Provider.of<PostProvider>(context, listen: false).currentUsername;
              Provider.of<PostProvider>(context, listen: false)
                  .addComment(widget.postId, username, _commentController.text);
              Navigator.of(context).pop(); // Close the dialog
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Comment cannot be empty.')),
              );
            }
          },
          child: Text('Submit Comment'),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.inversePrimary)),
        ),
      ],
    );
  }
}
