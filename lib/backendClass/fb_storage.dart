import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';


class FB_Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Upload_File(String filePath, String fileName , String email) async {
    bool verif = true;
   // File file = File(filePath);
    File compressedFile = await FlutterNativeImage.compressImage(filePath, quality: 5,);
    try {
      await storage.ref("${"profile/"+email+"/"}$fileName").putFile(compressedFile);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      verif = false;
    }
    return verif;
  }



    Upload_Images(String filePath, String fileName , String idTask) async {
    bool verif = true;
   // File file = File(filePath);
    File compressedFile = await FlutterNativeImage.compressImage(filePath, quality: 5,);
    try {
      await storage.ref("${"tasks/"+idTask+"/"}$fileName").putFile(compressedFile);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      verif = false;
    }
    return verif;
  }

  Upload_File_group(String filePath, String fileName) async {
    bool verif = true;
    File file = File(filePath);
    try {
      await storage.ref("${"/Groups/"}$fileName").putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      verif = false;
    }
    return verif;
  }

  static bool verif_file = true;
  Future<String> Get_file(String path) async {
    try {
      String url = await storage
          .ref(path)
          .getDownloadURL();
      return url;
    } on firebase_core.FirebaseException catch (e) {
      verif_file = false;
      throw Exception(e);
    }
  }



   Future<List<String>>imageTasks(String path) async {
   final ListResult result = await storage.ref(path).listAll();
    List<Reference> files = result.items;

    List<String> urls = [];
    for (var file in files) {
      String url = await file.getDownloadURL();
      urls.add(url);
    }
    
    return urls;
  }
  
}
