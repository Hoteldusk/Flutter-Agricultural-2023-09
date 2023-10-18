// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:agricultural/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  const MyPage({
    super.key,
    this.auth,
    this.productList,
  });
  final auth;
  final productList;
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    print("myPage");
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<UserStore>().userData;
    var storeFunc = context.read<UserStore>();

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
          "${widget.auth.currentUser!.displayName} 님 반갑습니다",
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
                data['money'].toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data['products'].length,
            itemBuilder: (c, i) {
              var indexData = data['products'][i];
              var todayPrice = indexData['total_price'] / indexData['count'];

              try {
                //   map자료형으로 반환
                var resultFirstWhere = widget.productList.firstWhere(
                    (map) => map['productName'] == indexData['name']);
                print('firstWhere 사용 결과: $resultFirstWhere');
                todayPrice =
                    int.parse(resultFirstWhere['dpr1'].replaceAll(',', ''));
              } catch (e) {
                print('해당하는 맵을 찾을 수 없습니다. : $e');
              }

              var benefit =
                  todayPrice - (indexData['total_price'] / indexData['count']);

              return Container(
                height: 100,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Column(
                  children: [
                    Text(indexData['name']),
                    Row(
                      children: [
                        const Text("보유개수 : "),
                        Text(indexData['count'].toString()),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("평단가 : "),
                        Text((indexData['total_price'] / indexData['count'])
                            .toString()),
                      ],
                    ),
                    Row(
                      children: [
                        // Text("수익 : $todayPrice"),
                        Text("득손실 : $benefit"),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
