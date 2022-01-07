import 'package:booklistsample/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class BookListModel extends ChangeNotifier {
  List<Book>? books; // Null許容

  void fetchBookList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('books').get();

    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String title = data['title'];
      final String author = data['author'];
      final String? imgURL = data['imgURL'];

      return Book(id, title, author, imgURL);
    }).toList();

    this.books = books;
    notifyListeners(); // 呼び元で発火
  }

  // (*1)
  delete(Book book) {
    FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }
}

// 動画では以下の紹介だったが、これでは認識されなかったので↑(*1)で。
// Future delete(Book book) {
//   return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
// }
