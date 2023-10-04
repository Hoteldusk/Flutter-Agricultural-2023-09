import 'package:agricultural/product_item.dart';
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
      body: ListView.builder(
        // Count 는 api데이터에서 소매리스트를 추출한 리스트의 길이
        itemCount: productList.length,
        itemBuilder: (c, i) {
          return ProductItem(product: productList[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.arrow_upward),
      ),
      // bottomNavigationBar: BottomNavigationBar(items: const []),
    );
  }
}
