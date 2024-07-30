import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/post_provider.dart';

class AddPostDialog extends StatefulWidget {
  @override
  _AddPostDialogState createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  final TextEditingController _contentController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      try {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });
        }
      } catch (e) {
        print('Error picking image: $e');
      }
    } else {
      // Handle permission not granted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission not granted. Please enable access to photos in settings.')),
      );
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Post'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 10),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.inversePrimary)),
            ),
          ],
        ),
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
            if (_contentController.text.isNotEmpty) {
              String username = Provider.of<PostProvider>(context, listen: false).currentUsername;
                  Provider.of<PostProvider>(context, listen: false).addPost(username, _contentController.text, _image); // Pass the image or null
              Navigator.of(context).pop(); // Close the dialog
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Content cannot be empty.')),
              );
            }
          },
          child: Text('Submit Post'),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.inversePrimary)),
        ),
      ],
    );
  }
}
