// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class UserStore extends ChangeNotifier {
  var userId = "";
  Map<String, dynamic> userData = {};

  initUserData(userId, nickname) async {
    try {
      await _firestore.collection('users').add({
        'money': 1000000,
        'products': [],
        'userId': userId,
        'nickname': nickname,
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
      userId = targetUserId;
      // 예제: userid 및 money 출력
      // print('UserID: ${userData['userId']}');
      // print('Money: ${userData['money']}');
    } else {
      print('해당 사용자를 찾을 수 없습니다.');
    }
  }

  void updateUserData(userData) {
    this.userData = userData;
    updateDB();
    notifyListeners();
  }

  void updateDB() async {
    try {
      // Firestore 컬렉션 참조
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // userId를 기준으로 문서를 찾기
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('userId', isEqualTo: userId)
              .get();

      // userId에 해당하는 문서가 존재하는지 확인
      if (querySnapshot.docs.isNotEmpty) {
        // userId에 해당하는 첫 번째 문서의 참조를 얻기
        DocumentReference userDocRef = users.doc(querySnapshot.docs.first.id);

        // 문서 업데이트
        await userDocRef.update(userData);

        print('문서 업데이트 성공!');
      } else {
        print('해당 userId를 가진 문서를 찾을 수 없습니다.');
      }
    } catch (e) {
      print('문서 업데이트 오류: $e');
    }
  }
}
