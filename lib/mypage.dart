// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:agricultural/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  const MyPage({
    super.key,
    this.auth,
    this.productList,
  });
  final auth;
  final productList;
  @override
  Widget build(BuildContext context) {
    var userData = context.watch<UserStore>().userData;

    // list<map> 탐색방법: firstWhere 사용 (해당하는 첫 번째 맵만 찾음)
    // try {
    //   map자료형으로 반환
    //   var resultFirstWhere =
    //       myList.firstWhere((map) => map['name'] == 'test14');
    //   print('firstWhere 사용 결과: $resultFirstWhere');
    // } catch (e) {
    //   print('해당하는 맵을 찾을 수 없습니다.');
    // }

    return Column(
      children: [
        Text(
          "${auth.currentUser!.displayName} 님 반갑습니다",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "남은 잔고 : ",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                userData['money'].toStringAsFixed(0),
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: userData['products'].length,
            itemBuilder: (c, i) {
              var indexData = userData['products'][i];
              var todayPrice = indexData['total_price'] / indexData['count'];

              try {
                //   map자료형으로 반환
                var resultFirstWhere = productList.firstWhere(
                    (map) => map['productName'] == indexData['name']);
                print('firstWhere 사용 결과: $resultFirstWhere');
                todayPrice =
                    int.parse(resultFirstWhere['dpr1'].replaceAll(',', ''));
              } catch (e) {
                print('해당하는 맵을 찾을 수 없습니다. : $e');
              }

              var benefit = (todayPrice -
                      (indexData['total_price'] / indexData['count'])) *
                  indexData['count'];

              var benefitPercent = (benefit / indexData['total_price']) * 100;

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

              Future<dynamic> showSellDialog() {
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
                              "상품 매도",
                              style: TextStyle(fontSize: 20),
                            ),
                            Column(
                              children: [
                                Text(
                                  "상품명 : ${indexData['name']}",
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "상품개수 : ${indexData['count']}",
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(100, 0, 100, 0),
                              child: Center(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  onChanged: (text) {
                                    countText = text;
                                  },
                                  decoration:
                                      const InputDecoration(labelText: '매도수량'),
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
                                // 보유 숫자보다 입력숫자가 많으면
                                if (indexData['count'] < int.parse(countText) &&
                                    nextLogic) {
                                  showBuyErrorDialog("보유 수량이 부족합니다");
                                  // 적으면
                                } else if (indexData['count'] >=
                                        int.parse(countText) &&
                                    nextLogic) {
                                  // 0개되면 삭제
                                  if (indexData['count'] -
                                          int.parse(countText) ==
                                      0) {
                                    userData['money'] +=
                                        (todayPrice * indexData['count']);
                                    userData['products'].removeAt(i);
                                    context
                                        .read<UserStore>()
                                        .updateUserData(userData);
                                  } else {
                                    var averagePrice = int.parse(countText) *
                                        (indexData['total_price'] /
                                            indexData['count']);

                                    userData['products'][i]['total_price'] -=
                                        averagePrice;

                                    userData['products'][i]['count'] -=
                                        int.parse(countText);

                                    userData['money'] += averagePrice;

                                    context
                                        .read<UserStore>()
                                        .updateUserData(userData);
                                  }
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('매도'),
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
                  showSellDialog();
                },
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        indexData['name'],
                        style: const TextStyle(fontSize: 17),
                      ),
                      Row(
                        children: [
                          const Text("보유개수 : "),
                          Text(indexData['count'].toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text("총 투자금 : "),
                              Text((indexData['total_price'])
                                  .toStringAsFixed(0)),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("평단가 : "),
                              Text((indexData['total_price'] /
                                      indexData['count'])
                                  .toStringAsFixed(0)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("득손실 : ${benefit.toStringAsFixed(0)}"),
                          Text("수익률 : ${benefitPercent.toStringAsFixed(1)}%"),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
