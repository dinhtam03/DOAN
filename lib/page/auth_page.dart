import 'package:flutter/material.dart';
import 'home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true; // true = form đăng nhập, false = form đăng ký
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // giả lập dữ liệu tài khoản lưu trong bộ nhớ tạm
  final Map<String, String> _users = {};

  void _submit() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin!')));
      return;
    }

    if (isLogin) {
      // kiểm tra đăng nhập
      if (_users.containsKey(username) && _users[username] == password) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Sai tài khoản hoặc mật khẩu!')));
      }
    } else {
      // kiểm tra đăng ký
      if (_confirmPasswordController.text != password) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Mật khẩu xác nhận không khớp!')));
        return;
      }
      if (_users.containsKey(username)) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Tài khoản đã tồn tại!')));
        return;
      }
      _users[username] = password;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Đăng ký thành công! Hãy đăng nhập.')));
      setState(() => isLogin = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Đăng nhập' : 'Đăng ký')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mật khẩu'),
              obscureText: true,
            ),
            if (!isLogin)
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Nhập lại mật khẩu'),
                obscureText: true,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text(isLogin ? 'Đăng nhập' : 'Đăng ký'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(isLogin
                  ? 'Chưa có tài khoản? Đăng ký'
                  : 'Đã có tài khoản? Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}
