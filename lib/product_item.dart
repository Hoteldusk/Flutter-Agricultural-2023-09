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
    // var sub = int.parse(product['dpr1']) - int.parse(product['dpr2']);
    // print("${product['productName']} : ${product['dpr2']}");

    var todayPrice = int.parse(product['dpr1'].replaceAll(',', ''));
    var yesterdayPrice;

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
    } else if (percentage <= 0) {
      strPercentage = "${percentage.toStringAsFixed(1)}%";
    }

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
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product['category_name'],
                          style:
                              const TextStyle(fontSize: 15, color: Colors.grey),
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
    );
  }
}
