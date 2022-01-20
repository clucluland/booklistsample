import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  // 初期値セットのためにコントローラを設置
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? email;
  String? password;

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future signUp() async {
    email = emailController.text;
    password = passwordController.text;

    // ログイン
  }
}
