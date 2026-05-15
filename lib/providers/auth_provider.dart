import 'package:flutter/material.dart';

import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;

  final List<UserModel> _users = [];

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  String? register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    if (fullName.trim().isEmpty ||
        email.trim().isEmpty ||
        password.trim().isEmpty ||
        confirmPassword.trim().isEmpty) {
      return 'Vui lòng nhập đầy đủ thông tin';
    }

    if (!email.contains('@')) {
      return 'Email không hợp lệ';
    }

    if (password.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }

    if (password != confirmPassword) {
      return 'Mật khẩu nhập lại không khớp';
    }

    final exists = _users.any(
          (user) => user.email.toLowerCase() == email.toLowerCase(),
    );

    if (exists) {
      return 'Email này đã được đăng ký';
    }

    final newUser = UserModel(
      fullName: fullName.trim(),
      email: email.trim(),
      password: password.trim(),
    );

    _users.add(newUser);
    _currentUser = newUser;

    notifyListeners();

    return null;
  }

  String? login({
    required String email,
    required String password,
  }) {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      return 'Vui lòng nhập email và mật khẩu';
    }

    try {
      final user = _users.firstWhere(
            (user) =>
        user.email.toLowerCase() == email.toLowerCase() &&
            user.password == password,
      );

      _currentUser = user;

      notifyListeners();

      return null;
    } catch (e) {
      return 'Email hoặc mật khẩu không đúng';
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}