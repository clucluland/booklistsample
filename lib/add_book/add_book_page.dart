import 'package:booklistsample/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('本を追加'),
        ),
        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: SizedBox(
                          width: 100,
                          height: 160,
                          child: model.imageFile != null
                              ? Image.file(model.imageFile!)
                              : Container(
                                  color: Colors.grey,
                                ),
                        ),
                        onTap: () async {
                          await model.pickImage();
                        },
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '本のタイトル',
                        ),
                        onChanged: (text) {
                          // ここで取得したtextを使う
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
                          // ここで取得したtextを使う
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
                            model.startLoading();
                            await model.addBook();
                            Navigator.of(context).pop(model.title);
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } finally {
                            // finaly は chatch しようがしまいがやってくる
                            model.endLoading();
                          }
                        },
                        child: const Text('追加する'),
                      ),
                    ],
                  ),
                ),
                if (model.isLoading) // ローディングのときだけ背景グレー
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
