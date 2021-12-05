import 'package:booklistsample/add_book/add_book_page.dart';
import 'package:booklistsample/book_list/book_list_model.dart';
import 'package:booklistsample/domain/book.dart';
import 'package:booklistsample/edit_book/edit_book_page.dart';
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
                    // key: const ValueKey(0),

                    // // The start action pane is the one at the left or the top side.
                    // startActionPane: ActionPane(
                    //   // A motion is a widget used to control how the pane animates.
                    //   motion: const ScrollMotion(),

                    //   // A pane can dismiss the Slidable.
                    //   dismissible: DismissiblePane(onDismissed: () {}),

                    //   // All actions are defined in the children parameter.
                    //   children: const [
                    //     // A SlidableAction can have an icon and/or a label.
                    //     SlidableAction(
                    //       onPressed: null,
                    //       backgroundColor: Color(0xFFFE4A49),
                    //       foregroundColor: Colors.white,
                    //       icon: Icons.delete,
                    //       label: 'Delete',
                    //     ),
                    //     SlidableAction(
                    //       onPressed: null,
                    //       backgroundColor: Color(0xFF21B7CA),
                    //       foregroundColor: Colors.white,
                    //       icon: Icons.share,
                    //       label: 'Share',
                    //     ),
                    //   ],
                    // ),
                    // The end action pane is the one at the right or the bottom side.
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          // flex: 2,
                          onPressed: (_) async {
                            // ここにボタンを押した時に呼ばれるコードを書く
                            final bool? added = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBookPage(),
                                fullscreenDialog: true,
                              ),
                            );

                            if (added != null && added) {
                              const snackBar = SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('本を編集しました。'),
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
                        const SlidableAction(
                          onPressed: null,
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
        }),
      ),
    );
  }
}
