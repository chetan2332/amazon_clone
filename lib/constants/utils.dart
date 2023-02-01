import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    final List<XFile> ximages = await ImagePicker().pickMultiImage();
    if (ximages.isNotEmpty) {
      for (int i = 0; i < ximages.length; i++) {
        images.add(File(ximages[i].path));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
