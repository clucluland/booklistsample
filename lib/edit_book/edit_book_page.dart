import 'package:booklistsample/edit_book/edit_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditBookModel>(
      create: (_) => EditBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('本を編集'),
        ),
        body: Center(
          child: Consumer<EditBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '本のタイトル',
                    ),
                    onChanged: (text) {
                      // TODO: ここで取得したtextを使う
                      model.title = text;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '本の著者',
                    ),
                    onChanged: (text) {
                      // TODO: ここで取得したtextを使う
                      model.author = text;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // 追加の処理
                      try {
                        await model.addBook();
                        Navigator.of(context).pop(true);
                        // const snackBar = SnackBar(
                        //   backgroundColor: Colors.green,
                        //   content: Text('成功'),
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } catch (e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.orange,
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text('更新する'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
