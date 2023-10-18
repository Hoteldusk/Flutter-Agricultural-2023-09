// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({
    super.key,
  });

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    print("안녕");
  }

  @override
  Widget build(BuildContext context) {
    return const Text("마이페이지");
  }
}
