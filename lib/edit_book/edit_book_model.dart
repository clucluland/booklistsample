import 'package:booklistsample/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditBookModel extends ChangeNotifier {
  final Book book;
  EditBookModel(this.book) {
    titleController.text = book.title;
    autherController.text = book.author;
  }

  // 初期値セットのためにコントローラを設置
  final titleController = TextEditingController();
  final autherController = TextEditingController();

  String? title;
  String? author;

  // notifyListeners()メソッドを使うと状態の変化を通知することができる
  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setAuthor(String author) {
    this.author = author;
    notifyListeners();
  }

  bool isUpdated() {
    return title != null || author != null;
  }

  // void → Future に変更
  Future addBook() async {
    // Firestore に登録
    await FirebaseFirestore.instance.collection('books').doc(book.id).update(
      {
        'title': title,
        'author': author,
      },
    );

    // title = null;
    // author = null;
  }
}
