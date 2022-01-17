import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier {
  String? title;
  String? author;
  File? imageFile;
  bool isLoading = false;

  final picker = ImagePicker();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  // void → Future に変更
  Future addBook() async {
    if (title == null || title == '') {
      throw 'タイトルが入力されていません。';
    }

    if (author == null || author == '') {
      throw '著者が入力されていません。';
    }

    final doc = FirebaseFirestore.instance.collection('books').doc();
    String? imgURL; // Null 許容の「?」

    // storageにアップロード
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('books/${doc.id})')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL(); // Future型なので await
    }

    // Firestore に登録
    // await FirebaseFirestore.instance.collection('books').add(
    await doc.set(
      {
        'title': title,
        'author': author,
        'imgURL': imgURL,
      },
    );

    // title = null;
    // author = null;
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}
