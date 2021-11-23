import 'package:booklistsample/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class BookListModel extends ChangeNotifier {
  // books が変化したら発火する(_usersStream)
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('books').snapshots();

  List<Book>? books; // Null許容

  void fetchBookList() {
    // 変化をリッスンする
    // 変化があれば snapshot が変わる
    _usersStream.listen((QuerySnapshot snapshot) {
      // mapで型変換
      // DocumentSnapshot → book に変換、変換して配列に入れる
      // title,authorを配列として取る
      final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data =
        document.data() as Map<String, dynamic>;
        final String title = data['title'];
        final String author = data['author'];
        return Book(title, author);
      }).toList();
      this.books = books;
      notifyListeners();  // 呼び元で発火
    });
    
  }
}