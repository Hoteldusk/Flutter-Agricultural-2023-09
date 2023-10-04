// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    this.product,
  });
  final product;
  @override
  Widget build(BuildContext context) {
    // todo: 뺄셈연산 수정중
    var sub = (num.tryParse(product['dpr1']) ?? 0) -
        (num.tryParse(product['dpr2']) ?? 0);

    var subData = num.tryParse(product['dpr1']).toString();

    return Container(
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
                flex: 1,
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product['category_name'],
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            product['dpr1'],
                            style: const TextStyle(
                                fontSize: 20, color: Colors.red),
                          ),
                          const Icon(
                            Icons.arrow_drop_up,
                            color: Colors.red,
                            size: 50,
                          ),
                        ],
                      ),
                      Text(
                        subData,
                        style: const TextStyle(fontSize: 20, color: Colors.red),
                      ),
                      const Text(
                        "4.60%",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
