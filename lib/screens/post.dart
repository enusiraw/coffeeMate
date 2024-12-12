import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yenebuna/services/location_service.dart';

import '../services/post_service.dart';

class PostPage extends StatefulWidget {
  static const String id = 'post';
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<XFile> _selectedImages = [];
  String _description = '';
  String _location = '';
  bool _isLoading = false;
  bool _useManualLocation = false; // Toggle for manual location input
  TextEditingController _manualLocationController = TextEditingController();

  // Get PostService from Provider
  PostService _postService = PostService();
  LocationService _locationService = LocationService();

  // Handle creating post
  Future<void> _handleCreatePost() async {
    if (_selectedImages.isEmpty || _description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add media and description')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userId = 'user_id'; // Replace with actual user ID
      // Get location based on user preference (manual or auto)
      final location = await _locationService.getLocation();

      final mediaUrls = await _postService.uploadMedia(_selectedImages);
      await _postService.createPost(
        userId: userId,
        description: _description,
        location: location,
        mediaUrls: mediaUrls,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post created successfully!')),
      );

      setState(() {
        _selectedImages.clear();
        _description = '';
        _location = '';
        _manualLocationController.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create post: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Select media (Camera or Gallery)
  Future<void> _selectMedia(bool fromCamera) async {
    final selectedFiles = await _postService.pickMedia(fromCamera: fromCamera);
    setState(() {
      _selectedImages.addAll(selectedFiles);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display selected images
            Expanded(
              child: ListView.builder(
                itemCount: _selectedImages.length,
                itemBuilder: (context, index) {
                  return Image.file(File(_selectedImages[index].path));
                },
              ),
            ),
            // Add description
            TextField(
              onChanged: (value) => setState(() {
                _description = value;
              }),
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            // Add location (toggle between manual or automatic location)
            Row(
              children: [
                Checkbox(
                  value: _useManualLocation,
                  onChanged: (value) {
                    setState(() {
                      _useManualLocation = value!;
                    });
                  },
                ),
                const Text('Use Manual Location'),
              ],
            ),
            // Location input field based on the toggle
            if (_useManualLocation)
              TextField(
                controller: _manualLocationController,
                decoration: const InputDecoration(labelText: 'Enter Location'),
              )
            else
              const SizedBox(
                height: 40,
                child: Center(
                  child: Text('Fetching your location...'),
                ),
              ),
            // Add buttons to pick media
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _selectMedia(true),
                  child: const Text('Take Photo'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _selectMedia(false),
                  child: const Text('Select from Gallery'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Submit post
            ElevatedButton(
              onPressed: _handleCreatePost,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}
