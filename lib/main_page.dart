// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

// import 'package:agricultural/api/json_server_api.dart';
import 'package:agricultural/api/kamis_api.dart';
import 'package:agricultural/mypage.dart';
import 'package:agricultural/product_list_page.dart';
import 'package:agricultural/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    this.auth,
  });

  final auth;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var productList = [];
  var _tab = 0;

  getData() async {
    var result = await KamisOpenAPI.loadAPI();
    var protoProductList = result['price'];
    // var protoProductList = await JsonServerAPI.loadAPI();
    setState(() {
      for (var i = 0; i < protoProductList.length; i++) {
        if (protoProductList[i]['product_cls_name'] == "소매") {
          productList.add(protoProductList[i]);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    context.read<UserStore>().getUserData(widget.auth.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: [
        ProductListPage(productList: productList),
        MyPage(
          auth: widget.auth,
          productList: productList,
        ),
      ][_tab],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.arrow_upward),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (i) {
            setState(() {
              _tab = i;
            });
          },
          currentIndex: _tab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "MyPage",
            ),
          ]),
    );
  }
}
