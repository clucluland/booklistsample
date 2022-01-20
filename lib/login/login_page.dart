import 'package:booklistsample/login/login_model.dart';
import 'package:booklistsample/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ログイン'),
        ),
        body: Center(
          child: Consumer<LoginModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: model.emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'E-mail',
                    ),
                    onChanged: (text) {
                      // model.email = text;
                      model.setEmail(text);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: model.passwordController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'パスワード',
                    ),
                    onChanged: (text) {
                      model.setPassword(text);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // 追加の処理
                      try {
                        await model.signUp();
                        // Navigator.of(context).pop(model.email);
                      } catch (e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.orange,
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text('ログイン'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: const Text('新規登録の方はこちら'),
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
