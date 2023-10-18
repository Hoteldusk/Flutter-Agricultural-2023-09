// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'package:agricultural/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key, this.auth});
  final auth;

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  var emailText = "";
  var pwText = "";
  var nickNameText = "";

  Future<dynamic> showJoinFailDialog() {
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
                    "회원가입 실패",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    "이메일형식, 비밀번호6자 이상",
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

  _join(nickname) async {
    try {
      var result = await widget.auth.createUserWithEmailAndPassword(
        email: emailText,
        password: pwText,
      );
      // 이름을 추가하고싶다면? 가입 진행후 이름을 추가해야함
      await result.user?.updateDisplayName(nickNameText);

      // DB에 회원 기본정보 저장
      // id : auth에 저장된 id , money : 1000000 , product : 빈배열
      String userId = widget.auth.currentUser!.uid;
      context.read<UserStore>().initUserData(userId, nickname);

      // 로그인화면으로 이동
      Navigator.pop(context);
    } catch (e) {
      // password 가 너무 짧거나, 6자 미만이거나, 이메일이 중복이거나
      print(e);
      showJoinFailDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (text) {
                nickNameText = text;
              },
              decoration: const InputDecoration(labelText: '닉네임'),
            ),
            const SizedBox(height: 60.0),
            // 회원가입 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _join(nickNameText),
                child: const Text('회원가입'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
