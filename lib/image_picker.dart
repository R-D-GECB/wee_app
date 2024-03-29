import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart' as galleryPicker;

class ImagePicker extends StatefulWidget {
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  FlashMode _flash = FlashMode.auto;
  var imagePath;

  Future<void> _initCams() async {
    final cameras = await availableCameras();
    final cam = cameras.first;
    _controller =
        CameraController(cam, ResolutionPreset.max, enableAudio: false);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          // ignore: unnecessary_statements
          : null;
    }
  }

  void takePhoto(context) async {
    //on camera button press
    try {
      XFile _file = await _controller.takePicture();
      imagePath = _file.path;
      print(_file.path);
      cropAndPass(imagePath, context);
    } catch (e) {
      print(e);
    }
  }

  void cropAndPass(String imagePath, context) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: imagePath,
        maxHeight: 300,
        maxWidth: 300,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: '',
          hideBottomControls: true,
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
        ),
        aspectRatio: CropAspectRatio(ratioX: 200, ratioY: 200));

    if (croppedImage != null) {
      Navigator.pop(context, croppedImage.path);
    }
  }

  void chooseFrmGallery(context) async {
    final picker = galleryPicker.ImagePicker();

    galleryPicker.PickedFile result = await picker.getImage(
        source: galleryPicker.ImageSource.gallery, imageQuality: 100);
    cropAndPass(result.path, context);
  }

  void toggleFlash() {
    if (_flash == FlashMode.off) {
      setState(() {
        _flash = FlashMode.auto;
        _controller.setFlashMode(_flash);
      });
      return;
    }
    if (_flash == FlashMode.auto) {
      setState(() {
        _flash = FlashMode.always;
        _controller.setFlashMode(_flash);
      });
      return;
    }
    if (_flash == FlashMode.always) {
      setState(() {
        _flash = FlashMode.off;
        _controller.setFlashMode(_flash);
      });
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initCams();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: AspectRatio(
                      child: CameraPreview(_controller),
                      aspectRatio: 1 / _controller.value.aspectRatio,
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Material(
                        color: Colors.black.withOpacity(0.5),
                        child: IconButton(
                            color: Colors.white.withOpacity(0.5),
                            icon: Icon(_flash == FlashMode.off
                                ? Icons.flash_off
                                : _flash == FlashMode.always
                                    ? Icons.flash_on
                                    : Icons.flash_auto),
                            onPressed: toggleFlash),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        chooseFrmGallery(context);
                      },
                      icon: Icon(
                        Icons.photo_library,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Gallery',
                        style: TextStyle(color: Colors.white),
                      )),
                  GestureDetector(
                      onTap: () {
                        takePhoto(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        height: 60,
                        width: 60,
                      )),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          );
        } else {
          return Center(
              child:
                  CircularProgressIndicator()); // Otherwise, display a loading indicator.
        }
      },
    );
  }
}
