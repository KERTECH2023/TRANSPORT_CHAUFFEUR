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
  Map<String, File?> imageFiles = {
    'image1.jpg': null,
    'image2.jpg': null,
    'image3.jpg': null,
    'image4.jpg': null,
    'image5.jpg': null,
  };

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
      setState(() {
        imageFiles[imageName] = imageFile;
      });
      uploadImage(imageFile, imageName);
    }
  }

  Widget buildUploadButton(String buttonText, String imageName) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[300],
          child: imageFiles[imageName] != null
              ? ClipOval(
                  child: Image.file(
                    imageFiles[imageName]!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                )
              : null,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => pickAndUploadImage(imageName),
          style: ElevatedButton.styleFrom(
            primary: Colors.black, // Set the button color to black
          ),
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white), // Set text color to white for contrast
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: SingleChildScrollView( // Wrap the entire content with SingleChildScrollView
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Upload your Papiers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'Add Your CIN (Recto) ', // Description for Image 1
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  buildUploadButton('Upload Image 1', 'image1.jpg'),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Add Your CIN (Verso)', // Description for Image 2
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  buildUploadButton('Upload Image 2', 'image2.jpg'),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Add your permit', // Description for Image 3
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  buildUploadButton('Upload Image 3', 'image3.jpg'),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Add your Insurance', // Description for Image 4
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  buildUploadButton('Upload Image 4', 'image4.jpg'),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Add your gray card ', // Description for Image 5
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  buildUploadButton('Upload Image 5', 'image5.jpg'),
                ],
              ),
              SizedBox(height: 20), // Add some spacing
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next main page
                  Navigator.pushNamed(context, "/main_screen");
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Set the button color to black
                ),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 16, color: Colors.white), // Set text color to white for contrast
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
