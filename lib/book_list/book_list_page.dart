import 'package:booklistsample/add_book/add_book_model.dart';
import 'package:booklistsample/add_book/add_book_page.dart';
import 'package:booklistsample/book_list/book_list_model.dart';
import 'package:booklistsample/domain/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('本一覧'),
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              // booksがnullのときぐるぐる待ち
              // book_list_model の fetchBookList() で値が取れるまで null
              return CircularProgressIndicator();
            }
            // ここより下は books は絶対 null でない
            final List<Widget> widgets = books.map(
                    (book) => ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.author),
                    ),
                  ).toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton: Consumer<BookListModel>(builder: (context, model, child) {
            return FloatingActionButton(
              onPressed: () async {
                // ここにボタンを押した時に呼ばれるコードを書く
                final bool? added = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddBookPage(),
                      fullscreenDialog: true,
                  ),
                );

                if (added != null && added) {
                  const snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('本を追加しました。'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                model.fetchBookList();
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            );
          }
        ),
      ),
    );
  }
}
