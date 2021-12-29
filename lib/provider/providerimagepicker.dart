import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AddImage with ChangeNotifier,DiagnosticableTreeMixin{
  File? fileImage;

  void UpdateImage() async{
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    // print(image!.path);
    fileImage = File(image!.path);
    notifyListeners();
  }

}