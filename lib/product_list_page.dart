import 'package:agricultural/product_item.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({
    super.key,
    required this.productList,
  });

  final List productList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(children: [
          Text("TODO")
          // TODO : 정렬 버튼 구현
        ]),
        Expanded(
          child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (c, i) {
              return ProductItem(product: productList[i]);
            },
          ),
        ),
      ],
    );
  }
}
