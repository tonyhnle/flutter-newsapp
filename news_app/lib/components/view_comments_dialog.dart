import 'package:flutter/material.dart';
import '../model/comment.dart';
import 'package:intl/intl.dart';

class ViewCommentsDialog extends StatelessWidget {
  final List<Comment> comments;

  ViewCommentsDialog({required this.comments});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('All Comments'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: comments.map((comment) => ListTile(
            title: Text(comment.userName, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(comment.content),
            trailing: Text(DateFormat('yyyy-MM-dd – kk:mm').format(comment.timestamp)),
          )).toList(),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
