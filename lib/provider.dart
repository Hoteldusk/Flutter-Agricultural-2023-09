// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class UserStore extends ChangeNotifier {
  var userData = {};

  initUserData(userId) async {
    try {
      await _firestore.collection('users').add({
        'money': 1000000,
        'products': [],
        'userId': userId,
      });
    } catch (e) {
      print("initUserData 오류발생 $e");
    }
  }

  void getUserData(String targetUserId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('userId', isEqualTo: targetUserId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // 결과에서 데이터를 추출합니다.
      userData = querySnapshot.docs.first.data();

      // 예제: userid 및 money 출력
      // print('UserID: ${userData['userId']}');
      // print('Money: ${userData['money']}');
    } else {
      print('해당 사용자를 찾을 수 없습니다.');
    }
  }
}
