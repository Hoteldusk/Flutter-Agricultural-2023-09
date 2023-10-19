// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:agricultural/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    this.product,
  });
  final product;
  @override
  Widget build(BuildContext context) {
    // var sub = int.parse(product['dpr1']) - int.parse(product['dpr2']);
    // print("${product['productName']} : ${product['dpr2']}");

    var todayPrice = int.parse(product['dpr1'].replaceAll(',', ''));
    var yesterdayPrice;
    var userData = context.watch<UserStore>().userData;

    if (product['dpr2'] is String) {
      yesterdayPrice = int.parse(product['dpr2'].replaceAll(',', ''));
    } else if (product['dpr2'] is List<dynamic>) {
      yesterdayPrice = todayPrice;
    }

    var subPrice = yesterdayPrice - todayPrice;
    double percentage = ((yesterdayPrice - todayPrice) / yesterdayPrice) * 100;

    var strPercentage;
    if (percentage > 0) {
      strPercentage = "+${percentage.toStringAsFixed(1)}%";
    } else if (percentage < 0) {
      strPercentage = " ${percentage.toStringAsFixed(1)}%";
    } else if (percentage == 0) {
      strPercentage = "  ${percentage.toStringAsFixed(1)}%";
    }

    Future<dynamic> showBuyErrorDialog(String errorText) {
      return showDialog(
        context: context,
        builder: (c) {
          return Dialog(
            child: SizedBox(
              height: 300,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(errorText),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("확인"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    Future<dynamic> showBuyDialog() {
      var countText = "";

      return showDialog(
        context: context,
        builder: (c) {
          return Dialog(
            child: SizedBox(
              height: 400,
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "상품 매수",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "${userData['nickname']} 님의 남은 잔고 : ${userData['money']}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Column(
                    children: [
                      Text(
                        "상품명 : ${product['productName']}",
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        "단일가 : $todayPrice",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (text) {
                          countText = text;
                        },
                        decoration: const InputDecoration(labelText: '매수수량'),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      bool nextLogic;
                      try {
                        nextLogic = true;
                        int.parse(countText);
                      } on FormatException {
                        nextLogic = false;
                        showBuyErrorDialog("숫자만 입력해주세요");
                      }
                      if (userData['money'] <
                              int.parse(countText) * todayPrice &&
                          nextLogic) {
                        showBuyErrorDialog("잔액이 부족합니다");
                      } else if (userData['money'] >=
                              int.parse(countText) * todayPrice &&
                          nextLogic) {
                        //
                        var resultFirstWhere = userData['products'].firstWhere(
                          (map) => map['name'] == product['productName'],
                          orElse: () => null, // 조건을 만족하는 요소가 없을 경우를 처리합니다.
                        );

                        if (resultFirstWhere != null) {
                          // 조건을 만족하는 요소를 찾았을 경우
                          final index =
                              userData['products'].indexOf(resultFirstWhere);
                          print('firstWhere 사용 결과: $resultFirstWhere');

                          resultFirstWhere['count'] += int.parse(countText);
                          print(resultFirstWhere['count']);

                          resultFirstWhere['total_price'] +=
                              int.parse(countText) * todayPrice;
                          print(resultFirstWhere['total_price']);

                          userData['products'][index] =
                              resultFirstWhere; // 수정할 Map으로 교체
                          print("index : $index");

                          userData['money'] -=
                              int.parse(countText) * todayPrice;

                          context.read<UserStore>().updateUserData(userData);

                          // userData['products']를 수정한 내용으로 업데이트했습니다.
                        } else {
                          print("리스트없음");
                          Map<String, dynamic> addMap = {
                            'total_price': 0,
                            'count': 0,
                            'name': "",
                          };
                          addMap['count'] += int.parse(countText);
                          addMap['total_price'] +=
                              int.parse(countText) * todayPrice;
                          addMap['name'] = product['productName'];

                          userData['products'].add(addMap);

                          userData['money'] -=
                              int.parse(countText) * todayPrice;

                          context.read<UserStore>().updateUserData(userData);

                          // 조건을 만족하는 요소가 없을 경우
                          // userData['products']에 추가 또는 다른 작업 수행
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('매수'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        showBuyDialog();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: Column(
          children: [
            Text(
              product['productName'],
              style: const TextStyle(fontSize: 20),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product['category_name'],
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            product['dpr1'],
                            style: TextStyle(
                              fontSize: 20,
                              color: subPrice < 0
                                  ? const Color.fromARGB(255, 0, 55, 255) // 파란색
                                  : subPrice == 0
                                      ? Colors.black
                                      : Colors.red,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Icon(
                            subPrice > 0
                                ? Icons.arrow_drop_up
                                : subPrice == 0
                                    ? Icons.remove
                                    : Icons.arrow_drop_down,
                            color: subPrice < 0
                                ? const Color.fromARGB(255, 0, 55, 255) // 파란색
                                : subPrice == 0
                                    ? Colors.black
                                    : Colors.red,
                            size: subPrice == 0 ? 30 : 50,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            subPrice.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: subPrice < 0
                                  ? const Color.fromARGB(255, 0, 55, 255) // 파란색
                                  : subPrice == 0
                                      ? Colors.black
                                      : Colors.red,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            strPercentage,
                            style: TextStyle(
                              fontSize: 20,
                              color: subPrice < 0
                                  ? const Color.fromARGB(255, 0, 55, 255) // 파란색
                                  : subPrice == 0
                                      ? Colors.black
                                      : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
