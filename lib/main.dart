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
          return Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Image(
                    image: AssetImage("images/apple.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 130,
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "사과",
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              "과일류",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "당 일   ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "54,974",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "+4.60",
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(
                              Icons.arrow_drop_up,
                              color: Colors.red,
                              size: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
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
