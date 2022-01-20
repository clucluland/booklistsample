import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
  // 初期値セットのためにコントローラを設置
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? email;
  String? password;

  // notifyListeners()メソッドを使うと状態の変化を通知することができる
  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  // void → Future に変更
  Future signUp() async {
    // 更新時、入力内容を this にセット
    // TextBoxの更新がなければ set*()メソッドが走らないため、
    // 更新しなかった値は null になる。
    email = emailController.text;
    password = passwordController.text;

    // firebase auth でユーザ作成

    // firebase に追加

    // Firestore に登録
    // await FirebaseFirestore.instance.collection('books').doc(book.id).update(
    //   {
    //     'email': email,
    //     'password': password,
    //   },
    // );

    // email = null;
    // password = null;
  }
}
