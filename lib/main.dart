import 'package:agricultural/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:agricultural/api/kamis_api.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: App(),
  ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var productList = [];
  var _tab = 0;

  getData() async {
    var result = await KamisOpenAPI.loadAPI();
    var protoProductList = result['price'];
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: [
        ProductListPage(productList: productList),
        const Text("마이페이지")
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
