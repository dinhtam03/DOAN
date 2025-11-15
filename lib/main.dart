import 'package:flutter/material.dart';
import 'page/auth_page.dart';

void main() {
  runApp(const ChiTieuApp());
}

class ChiTieuApp extends StatelessWidget {
  const ChiTieuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý chi tiêu cá nhân',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const AuthPage(), // 👉 Mở trang đăng nhập đầu tiên
    );
  }
}
