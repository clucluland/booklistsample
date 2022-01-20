import 'package:booklistsample/add_book/add_book_page.dart';
import 'package:booklistsample/book_list/book_list_model.dart';
import 'package:booklistsample/domain/book.dart';
import 'package:booklistsample/edit_book/edit_book_page.dart';
import 'package:booklistsample/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('本一覧'),
          actions: [
            IconButton(
                onPressed: () async {
                  // ログイン画面
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                icon: const Icon(Icons.person)),
          ],
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              // booksがnullのときぐるぐる待ち
              // book_list_model の fetchBookList() で値が取れるまで null
              return const CircularProgressIndicator();
            }
            // ここより下は books は絶対 null でない
            final List<Widget> widgets = books
                .map(
                  (book) => Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          // flex: 2,
                          onPressed: (_) async {
                            // ここに編集ボタンを押した時に呼ばれるコードを書く
                            final String? updateTitle = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBookPage(book),
                              ),
                            );

                            if (updateTitle != null) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('"$updateTitle"を編集しました。'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            model.fetchBookList();
                          },
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: '編集',
                        ),
                        SlidableAction(
                          onPressed: (_) async {
                            // ここに削除ボタンを押したときのコードを書く
                            await showConfirmDialog(context, book, model);
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: '削除',
                        ),
                      ],
                    ),

                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.
                    // child: const ListTile(title: Text('Slide me')),

                    child: ListTile(
                      // Null でないときのみ表示
                      leading: book.imgURL != null
                          ? Image.network(book.imgURL!)
                          : null,
                      title: Text(book.title),
                      subtitle: Text(book.author),
                    ),
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              // ここにボタンを押した時に呼ばれるコードを書く
              final String? addTitle = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );

              if (addTitle != null) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('"$addTitle"を追加しました。'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              model.fetchBookList();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}

Future showConfirmDialog(
  BuildContext context,
  Book book,
  BookListModel model,
) {
  return showDialog(
    context: context,
    barrierDismissible: true, // ダイアログの外側でタップしたらキャンセル扱い
    builder: (_) {
      return AlertDialog(
        title: const Text("削除確認"),
        content: Text("『${book.title}』を削除しますか？"),
        actions: [
          TextButton(
            child: const Text("いいえ"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("はい"),
            // onPressed: () => print('OK'),
            onPressed: () async {
              // model 削除
              await model.delete(book);
              Navigator.pop(context);

              final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text('"${book.title}"を削除しました。'),
              );
              model.fetchBookList();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      );
    },
  );
}
