import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> uploadImage(File imageFile, String imageName) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;
        Reference storageRef = _storage.ref().child('user_images/$userId/$imageName');
        await storageRef.putFile(imageFile);
        print('Image uploaded successfully: $imageName');
      } else {
        print('User is not authenticated');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> pickAndUploadImage(String imageName) async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      uploadImage(imageFile, imageName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => pickAndUploadImage('image1.jpg'),
              child: Text('Upload Image 1'),
            ),
            ElevatedButton(
              onPressed: () => pickAndUploadImage('image2.jpg'),
              child: Text('Upload Image 2'),
            ),
            ElevatedButton(
              onPressed: () => pickAndUploadImage('image3.jpg'),
              child: Text('Upload Image 3'),
            ),
            ElevatedButton(
              onPressed: () => pickAndUploadImage('image4.jpg'),
              child: Text('Upload Image 4'),
            ),
            ElevatedButton(
              onPressed: () => pickAndUploadImage('image5.jpg'),
              child: Text('Upload Image 5'),
            ),
          ],
        ),
      ),
    );
  }
}
