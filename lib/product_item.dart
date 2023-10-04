import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "54,974",
                        style: TextStyle(fontSize: 20),
                      ),
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
  }
}
