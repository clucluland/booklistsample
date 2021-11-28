import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  String? title;
  String? author;

  // void → Future に変更
  Future addBook() async{
    if (title == null || title == '') {
      throw 'タイトルが入力されていません。';
    }

    if (author == null || author == '') {
      throw '著者が入力されていません。';
    }

    // Firestore に登録
    await FirebaseFirestore.instance.collection('books').add({
      'title': title,
      'author': author,
    },);

    // title = null;
    // author = null;

  }

}