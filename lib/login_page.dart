// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:agricultural/join_page.dart';
import 'package:agricultural/main_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailText = "";
  var pwText = "";

  _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailText,
        password: pwText,
      );
      print('로그인 성공: ${userCredential.user!.email}');
      // 메인페이지 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(auth: _auth),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print('로그인 실패: $e');
      showLoginFailDialog();
    }
  }

  Future<dynamic> showLoginFailDialog() {
    return showDialog(
        context: context,
        builder: (c) {
          return Dialog(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "로그인 실패",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    "이메일, 비밀번호를 확인해주세요",
                    style: TextStyle(fontSize: 15),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('확인'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Column(
            children: [
              Text(
                "글 팜",
                style: TextStyle(fontSize: 50),
              ),
              Text(
                "농산물 모의투자",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (text) {
                  emailText = text;
                },
                decoration: const InputDecoration(labelText: '이메일'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                onChanged: (text) {
                  pwText = text;
                },
                obscureText: true,
                decoration: const InputDecoration(labelText: '비밀번호'),
              ),
              const SizedBox(height: 60.0),
              // 로그인 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text('로그인'),
                ),
              ),
              const SizedBox(height: 8.0),
              // 회원가입 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JoinPage(auth: _auth),
                      ),
                    );
                  },
                  child: const Text('회원가입'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
