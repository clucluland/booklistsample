import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  // 初期値セットのためにコントローラを設置
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? email;
  String? password;
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future login() async {
    email = emailController.text;
    password = passwordController.text;

    // ログイン
  }
}
