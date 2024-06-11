import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_plannerx/db/database_file/image_db_functions.dart';
import 'package:trip_plannerx/model/images_blogs_db.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trip_plannerx/screens/profile_screens/fullscreen_img.dart';
import 'package:trip_plannerx/widgets/alertbox_img_delete.dart';

class ImagesPage extends StatefulWidget {
  final int tripId;

  const ImagesPage({Key? key, required this.tripId}) : super(key: key);

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  late Box<ImageBlog>? imageBlogBox;
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    requestPermissions();
    initDbAndLoadImages();
  }

  Future<void> requestPermissions() async {
    await Permission.storage.request();
    await Permission.camera.request();
  }

  Future<void> initDbAndLoadImages() async {
    await ImageDbService.init();
    setState(() {
      if (widget.tripId == -1) {
        images = ImageDbService.getAllImagesFromAllTrips();
      } else {
        images = ImageDbService.getImages(widget.tripId.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPhotosFromGallery,
        child: const Icon(Icons.add_a_photo_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImagePage(
                      imagePath: images[index],
                    ),
                  ),
                );
              },
              onLongPress: () {
                ImgDeleteDialog.showDeleteDialog(
                  context,
                  index,
                  () => _deleteImage(index),
                );
              },
              child: _buildImageWidget(images[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageWidget(String imagePath) {
    File imageFile = File(imagePath);
    if (!imageFile.existsSync()) {
      return Container(
        color: Colors.grey[300],
        child: const Icon(Icons.error),
      );
    }
    return Image.file(
      imageFile,
      fit: BoxFit.cover,
    );
  }

  Future<void> _addPhotosFromGallery() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      List<String> newImages = pickedFiles.map((file) => file.path).toList();
      await ImageDbService.addImages(newImages, widget.tripId.toString());
      setState(() {
        images = ImageDbService.getImages(widget.tripId.toString());
      });
    }
  }

  void _deleteImage(int index) async {
    await ImageDbService.deleteImage(index, widget.tripId.toString());
    setState(() {
      images = ImageDbService.getImages(widget.tripId.toString());
    });
  }
}

