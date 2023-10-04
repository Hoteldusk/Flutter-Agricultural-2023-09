import 'package:agricultural/product_item.dart';
import 'package:flutter/material.dart';
import 'package:agricultural/api/kamis_api.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                KamisOpenAPI.loadAPI();
              },
              icon: const Icon(Icons.api_outlined))
        ],
      ),
      body: ListView.builder(
        // Count 는 api데이터에서 소매리스트를 추출한 리스트의 길이
        itemCount: 70,
        itemBuilder: (c, i) {
          return const ProductItem();
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
