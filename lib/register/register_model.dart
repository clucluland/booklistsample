import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

    if (email != null && password != null) {
      // firebase auth でユーザ作成
      // Firebase Authenticationを利用するためのインスタンス
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      final user = userCredential.user;
      if (user != null) {
        final uid = user.uid;

        // Firestore に登録
        final doc = FirebaseFirestore.instance.collection('users').doc(uid);
        await doc.set({
          'uid': uid,
          'email': email,
        });
      }
    }
  }
}
